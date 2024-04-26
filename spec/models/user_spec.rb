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
end
