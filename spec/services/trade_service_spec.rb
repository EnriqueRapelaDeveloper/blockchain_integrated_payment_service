require 'rails_helper'

RSpec.describe FeeService, type: :model do
  let(:user) { create(:user) }
  let!(:fee_configuration) { create(:fee_configuration, user:) }

  before do
    @service = TradeService.new(user, 10_000, 'EUR')
  end

  describe '#execute' do
    before do
      @service.execute
    end

    it 'create the trade' do
      expect(Trade.count).to eq 1
    end

    it 'create the fee object' do
      expect(Trade.first.fee).to be_present
    end
  end

  describe '#calculate_fee' do
    before do
      @original_amount_for_trade = @service.send('calculate_fee')
    end

    it 'calculate the correct original amount' do
      expect(@original_amount_for_trade).to eq 10_000 - 10_000 * (fee_configuration.trades_percentage / 100)
    end
  end

  describe '#calculate_conversion' do
    it 'returns the correct amount and currency to conversion' do
      expect(@service.send('calculate_conversion')).to eq [10_000 * 1.20, 'USDT']
    end
  end

  describe '#update_trade' do
    it 'create the trade with correct amounts' do
      @service.send('update_trade', 10_000 * 1.20, 'USDT')

      trade = Trade.last

      expect(trade.original_amount_cents).to eq 10_000
      expect(trade.original_amount_currency).to eq 'EUR'
      expect(trade.final_amount_cents).to eq 10_000 * 1.20
      expect(trade.final_amount_currency).to eq 'USDT'
    end
  end
end
