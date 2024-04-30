require 'rails_helper'

RSpec.describe BlockchainPayment, type: :model do
  let(:user) { create(:user) }
  context 'validations' do
    it 'is valid with correct parameters' do
      blockchain_payment = BlockchainPayment.new(user_id: user.id, amount_cents: 10_000)
      expect(blockchain_payment).to be_valid
    end
  end
end
