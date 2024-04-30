require 'rails_helper'

RSpec.describe FeeService, type: :model do
  let(:user) { create(:user) }
  let!(:fee_configuration) { create(:fee_configuration, user:) }

  before do
    @service = BlockchainService.new(user, 10_000, 'USDT')
  end

  describe '#execute' do
    before do
      @service.execute

      @bp = BlockchainPayment.first
    end

    it 'create blockchain object' do
      expect(@bp).to be_present
      expect(@bp.amount_cents).to eq 10_000 - (10_000 * 0.01)
    end

    it 'create fee object' do
      expect(@bp.fee).to be_present
      expect(@bp.fee.amount_cents).to eq 10_000 * 0.01
      expect(@bp.fee.amount_currency).to eq 'USDT'
    end
  end

  describe '#calculate_fee' do
    it 'update the bp price, applying the correct fee' do
      @service.execute

      bp = BlockchainPayment.first

      expect(bp.amount_cents).to eq 10_000 - (10_000 * 0.01)
    end
  end
end
