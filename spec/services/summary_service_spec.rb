require 'rails_helper'

RSpec.describe FeeService, type: :model do
  let(:user) { create(:user) }
  let!(:fee_configuration) { create(:fee_configuration, user:, payments: false) }
  let!(:fiat_payment) { create(:fiat_payment, user:) }

  describe '#monthly_rates' do
    it 'generate correct json' do
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
  end
end
