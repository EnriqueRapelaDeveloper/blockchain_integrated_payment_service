require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :request do
  describe 'registrate a new user' do
    it 'with success response' do
      post '/api/v1/signup', params: { user: { email: 'test@test.com', password: '123456' } }

      expect(response).to have_http_status(:success)
    end

    it 'with invalid parameters' do
      post '/api/v1/signup', params: { user: { email: 'testtest.com', password: '1234' } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
