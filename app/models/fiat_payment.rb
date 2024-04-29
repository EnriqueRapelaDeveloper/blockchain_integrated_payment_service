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

  has_one :fee, as: :transactionable

  before_create :generate_uid
  before_create :charged_fee
  after_create :execute_trade

  monetize :amount_cents, numericality: {
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 10000
                          }

  def generate_uid
    self.uuid = SecureRandom.uuid
  end

  def charged_fee
    fee_service = FeeService.new(self, user.fee_configuration)
    fee_amount_cents = fee_service.get_fees(amount_cents)
    fee_service.collect(amount_cents, amount_currency)

    return unless user.fee_configuration.payments

    self.amount_cents = amount_cents - fee_amount_cents
  end

  def execute_trade
    TradeService.new(user, amount_cents, amount_currency).execute
  end
end
