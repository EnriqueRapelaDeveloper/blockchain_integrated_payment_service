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

    it 'with invalid fee configuration' do
      post :create, params: { user: { email: 'test@test.com', password: '123456', fee_configuration: { trades: true, trades_percentage: 110 } } }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'with valid fee configuration' do
      post :create, params: { user: { email: 'test@test.com', password: '123456', fee_configuration: { trades: true, trades_percentage: 20 } } }

      expect(response).to have_http_status(:ok)
      expect(User.last.fee_configuration.trades_percentage).to eq 20
    end

    it 'register with the same email that other user' do
      user = create(:user)

      post :create, params: { user: { email: user.email, password: '123456' } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
