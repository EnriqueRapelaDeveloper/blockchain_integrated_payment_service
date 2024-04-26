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
class FeeConfigurationSerializer
  include JSONAPI::Serializer
  set_id :uuid
  attributes :trades, :trades_percentage, :payments, :payments_percentage
end
