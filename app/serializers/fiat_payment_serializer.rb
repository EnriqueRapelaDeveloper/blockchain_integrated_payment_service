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
class FiatPaymentSerializer
  include JSONAPI::Serializer
  set_id :uuid
  attributes :amount_cents, :amount_currency, :created_at
  has_one :fee, serializer: FeeSerializer, id_method_name: :uuid
end
