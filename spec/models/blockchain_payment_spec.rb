# == Schema Information
#
# Table name: blockchain_payments
#
#  id              :bigint           not null, primary key
#  amount_cents    :bigint
#  amount_currency :string
#  uuid            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_blockchain_payments_on_user_id  (user_id)
#
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
