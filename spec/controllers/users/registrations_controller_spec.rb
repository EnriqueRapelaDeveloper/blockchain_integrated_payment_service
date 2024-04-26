require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'registrate a new user' do
    it 'with success response' do
      post :create, params: { user: { email: 'test@test.com', password: '123456' } }

      expect(response).to have_http_status(:success)
    end

    it 'with invalid parameters' do
      post :create, params: { user: { email: 'testtest.com', password: '1234' } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
