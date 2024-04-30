# == Schema Information
#
# Table name: fiat_payments
#
#  id              :bigint           not null, primary key
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("EUR"), not null
#  uuid            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_fiat_payments_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe FiatPayment, type: :model do
  let(:user) { create(:user) }
  context 'validations' do
    it "is not valid with negative amount" do
      fiat_payment = FiatPayment.new(user_id: user.id, amount_cents: -10000)
      expect(fiat_payment).to_not be_valid
    end

    it "is not valid with amount cents greater than 1000000" do
      fiat_payment = FiatPayment.new(user_id: user.id, amount_cents: 100000001)
      expect(fiat_payment).to_not be_valid
    end

    it 'is valid with correct parameters' do
      fiat_payment = FiatPayment.new(user_id: user.id, amount_cents: 10000)
      expect(fiat_payment).to be_valid
    end
  end
end
