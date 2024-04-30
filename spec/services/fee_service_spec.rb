require 'rails_helper'

RSpec.describe FeeService, type: :model do
  let(:user) { create(:user) }
  let!(:fee_configuration) { create(:fee_configuration, user:) }


  before do
    @fiat_payment = FiatPayment.new(amount_cents: 10_000, amount_currency: 'EUR', user:)
    @service = FeeService.new(@fiat_payment, user.fee_configuration)
  end

  describe '#collect' do
    it 'create fee for fiat payment' do
      @service.collect(@fiat_payment.amount_cents, @fiat_payment.amount_currency)

      @fiat_payment.save

      percentage = user.fee_configuration.payments_percentage

      expect(@fiat_payment.fee).to be_present
      expect(@fiat_payment.fee.amount_cents).to eq 10_000 * (percentage / 100)
    end
  end

  describe '#get_fees' do
    it 'return fee amount' do
      fee_amount = @service.get_fees(@fiat_payment.amount_cents)

      percentage = user.fee_configuration.payments_percentage

      expect(fee_amount).to eq 10_000 * (percentage / 100)
    end
  end

  describe '#type_of_fee' do
    it 'return correct type of fee to apply on payments' do
      expect(@service.send('type_of_fee')).to eq 'payments'
    end

    it 'return correct type of fee to apply on trades' do
      @trade = Trade.new(original_amount_cents: 10_000, original_amount_currency: 'EUR', user:)
      @service = FeeService.new(@trade, user.fee_configuration)

      expect(@service.send('type_of_fee')).to eq 'trades'
    end
  end

  describe '#calculate_fee' do
    it 'return the correct fee' do
      fee_amount = @service.send('get_fees', @fiat_payment.amount_cents)

      percentage = user.fee_configuration.payments_percentage

      expect(fee_amount).to eq 10_000 * (percentage / 100)
    end
  end

  describe '#create_fee' do
    it 'build the fee object related to the fiat payment' do
      fee_amount_cents = @service.send('get_fees', @fiat_payment.amount_cents)

      @service.send('create_fee', 'payments', fee_amount_cents, 'EUR')
      percentage = user.fee_configuration.payments_percentage

      expect(@fiat_payment.fee).to be_present
      expect(@fiat_payment.fee.amount_cents).to eq 10_000 * (percentage / 100)
    end
  end
end
