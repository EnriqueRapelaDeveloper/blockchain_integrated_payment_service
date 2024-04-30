# == Schema Information
#
# Table name: blockchain_payments
#
#  id              :bigint           not null, primary key
#  amount_cents    :float
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
class BlockchainPayment < ApplicationRecord
  belongs_to :user

  has_one :fee, as: :transactionable

  before_create :generate_uid

  validates :amount_cents, numericality: {
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 10000
                          }

  def generate_uid
    self.uuid = SecureRandom.uuid
  end
end
