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
class Trade < ApplicationRecord
  belongs_to :user

  has_one :fee, as: :transactionable

  before_create :generate_uid
  after_create :execute_blockchain_payment

  validates :original_amount_cents, numericality: {
                                     greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 100000000
                                   }

  validates :final_amount_cents, numericality: {
                                  greater_than_or_equal_to: 0,
                                  less_than_or_equal_to: 100000000
                                }

  def generate_uid
    self.uuid = SecureRandom.uuid
  end

  def execute_blockchain_payment
    BlockchainService.new(user, final_amount_cents, final_amount_currency).execute
  end
end
