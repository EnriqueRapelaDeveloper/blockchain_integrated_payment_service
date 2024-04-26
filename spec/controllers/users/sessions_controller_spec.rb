require 'rails_helper'

RSpec.describe Users::SessionsController, type: :request do
  let(:user){ create(:user) }

  describe 'loggin' do
    it 'with a correct user data' do
      post '/api/v1/login', params: { user: { email: user.email, password: user.password } }

      expect(response).to have_http_status(:success)
    end

    it 'with invalid parameters' do
      post '/api/v1/login', params: { user: { email: user.email, password: '1234' } }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'logout' do
    it 'with correct jwt' do
      post '/api/v1/login', params: { user: { email: user.email, password: user.password } }
      authorization = response.headers['authorization']
      delete '/api/v1/logout', headers: { Authorization: authorization }

      expect(response).to have_http_status(:ok)
    end

    it 'with invalid jwt' do
      post '/api/v1/login', params: { user: { email: user.email, password: user.password } }

      delete '/api/v1/logout', headers: { Authorization: 'invalid_token' }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
