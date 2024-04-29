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
FactoryBot.define do
  factory :fiat_payment do
    amount_cents { 10000 }
    amount_currency { 'EUR' }
    user
  end
end
