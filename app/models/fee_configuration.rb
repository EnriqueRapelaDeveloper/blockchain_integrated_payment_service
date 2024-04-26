# == Schema Information
#
# Table name: fee_configurations
#
#  id                  :bigint           not null, primary key
#  payments            :boolean          default(TRUE), not null
#  payments_percentage :float            default(1.0)
#  trades              :boolean          default(TRUE), not null
#  trades_percentage   :float            default(1.0)
#  uuid                :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_fee_configurations_on_user_id  (user_id)
#
class FeeConfiguration < ApplicationRecord
  belongs_to :user

  before_create :generate_uid

  validates :payments_percentage, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
  validates :trades_percentage, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }

  def generate_uid
    self.uuid = SecureRandom.uuid
  end
end
