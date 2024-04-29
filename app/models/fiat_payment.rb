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
class FiatPayment < ApplicationRecord
  belongs_to :user

  before_create :generate_uid

  monetize :amount_cents, numericality: {
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 10000
                          }

  def generate_uid
    self.uuid = SecureRandom.uuid
  end
end
