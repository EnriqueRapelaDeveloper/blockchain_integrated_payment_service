require 'rails_helper'

RSpec.describe FeeService, type: :model do
  let(:user) { create(:user) }
  let!(:fee_configuration) { create(:fee_configuration, user:, payments: false) }
  let!(:fiat_payment) { create(:fiat_payment, user:) }

  let(:user2) { create(:user, email: 'test2@test.com') }
  let!(:fee_configuration2) { create(:fee_configuration, user:, payments: false) }
  let!(:fiat_payment2) { create(:fiat_payment, user: user2) }

  describe '#monthly_rates' do
    it 'generate correct json for user 1' do
      json = SummaryService.new(user).monthly_rates

      expect(json).to eq ({
        paid_fees: [
          {
            amount_cents: 100,
            amount_currency: 'EUR'
          }
        ],
        unpaid_fees: [
          {
            amount_cents: 100,
            amount_currency: 'EUR'
          },
          {
            amount_cents: 118,
            amount_currency: 'USDT'
          }
        ]
      })
    end

    it 'generate correct json for user 2' do
      json = SummaryService.new(user2).monthly_rates

      expect(json).to eq ({
        paid_fees: [
          {
            amount_cents: 199,
            amount_currency: 'EUR'
          },
          {
            amount_cents: 117,
            amount_currency: 'USDT'
          }
        ],
        unpaid_fees: []
      })
    end
  end
end
