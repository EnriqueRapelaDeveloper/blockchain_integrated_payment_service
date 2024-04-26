# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  jti                    :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uuid                   :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_jti                   (jti) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do

  context 'validations' do
    it "is not valid with invalid email" do
      user = User.new(email: 'test.com', password: '123456')
      expect(user).to_not be_valid
    end

    it "is not valid with invalid password" do
      user = User.new(email: 'test@test.com', password: '1')
      expect(user).to_not be_valid
    end

    it 'is valid with correct parameters' do
      user = User.new(email: 'test@test.com', password: '123456')
      expect(user).to be_valid
    end
  end

  context 'before_create actions' do
    before do
      @user = User.new(email: 'test@test.com', password: '123456')
    end

    it 'when create the user, the model generate a uuid' do
      @user.save

      expect(@user.uuid).not_to be_empty
    end
  end

  context 'after_create actions' do
    before do
      @user = User.new(email: 'test@test.com', password: '123456')
    end

    it 'when create the user, the model generate a uuid' do
      @user.save

      expect(@user.fee_configuration).to eq FeeConfiguration.last
    end
  end
end
