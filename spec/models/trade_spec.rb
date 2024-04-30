require 'rails_helper'

RSpec.describe Trade, type: :model do
  let(:user) { create(:user) }
  context 'validations' do
    it 'is valid with correct parameters' do
      trade = Trade.new(user_id: user.id, original_amount_cents: 10_000)
      expect(trade).to be_valid
    end
  end
end
