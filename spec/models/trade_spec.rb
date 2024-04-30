# == Schema Information
#
# Table name: trades
#
#  id                       :bigint           not null, primary key
#  final_amount_cents       :bigint
#  final_amount_currency    :string
#  original_amount_cents    :bigint
#  original_amount_currency :string
#  uuid                     :string           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  user_id                  :bigint           not null
#
# Indexes
#
#  index_trades_on_user_id  (user_id)
#
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
