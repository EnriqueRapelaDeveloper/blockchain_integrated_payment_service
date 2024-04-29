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
#
# Indexes
#
#  index_fees_on_transactionable  (transactionable_type,transactionable_id)
#
class Fee < ApplicationRecord
  belongs_to :transactionable, polymorphic: true

  before_create :generate_uid

  def generate_uid
    self.uuid = SecureRandom.uuid
  end
end
