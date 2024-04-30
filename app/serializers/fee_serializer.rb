# == Schema Information
#
# Table name: fees
#
#  id                   :bigint           not null, primary key
#  amount_cents         :integer          default(0), not null
#  amount_currency      :string           default("USD"), not null
#  paid                 :boolean          not null
#  transactionable_type :string           not null
#  uuid                 :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  transactionable_id   :bigint           not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_fees_on_transactionable  (transactionable_type,transactionable_id)
#  index_fees_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class FeeSerializer
  include JSONAPI::Serializer
  set_id :uuid
  attributes :amount_cents, :amount_currency, :paid, :created_at
end
