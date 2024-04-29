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
require 'rails_helper'

RSpec.describe FeeConfiguration, type: :model do
  let(:user) { create(:user) }
  context 'validations' do
    it "is not valid with negative payments percentage" do
      fee_configuration = FeeConfiguration.new(user_id: user.id, payments: true, payments_percentage: -5)
      expect(fee_configuration).to_not be_valid
    end

    it "is not valid with trades percentage greater than 100" do
      fee_configuration = FeeConfiguration.new(user_id: user.id, trades: true, trades_percentage: 110)
      expect(fee_configuration).to_not be_valid
    end

    it 'is valid with correct parameters' do
      fee_configuration = FeeConfiguration.new(user_id: user.id, trades: true, trades_percentage: 10)
      expect(fee_configuration).to be_valid
    end
  end
end
