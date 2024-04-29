# == Schema Information
#
# Table name: trades
#
#  id                       :bigint           not null, primary key
#  final_amount_cents       :integer          default(0), not null
#  final_amount_currency    :string           default("USD"), not null
#  original_amount_cents    :integer          default(0), not null
#  original_amount_currency :string           default("USD"), not null
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

  monetize :original_amount_cents, numericality: {
                                     greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 10000
                                   }

  monetize :final_amount_cents, numericality: {
                                  greater_than_or_equal_to: 0,
                                  less_than_or_equal_to: 10000
                                }

  def generate_uid
    self.uuid = SecureRandom.uuid
  end
end
