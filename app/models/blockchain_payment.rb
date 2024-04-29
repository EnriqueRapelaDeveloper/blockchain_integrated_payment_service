# == Schema Information
#
# Table name: blockchain_payments
#
#  id         :bigint           not null, primary key
#  amount     :float
#  currency   :string
#  uuid       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_blockchain_payments_on_user_id  (user_id)
#
class BlockchainPayment < ApplicationRecord
  belongs_to :user

  has_one :fee, as: :transactionable

  before_create :generate_uid

  def generate_uid
    self.uuid = SecureRandom.uuid
  end
end
