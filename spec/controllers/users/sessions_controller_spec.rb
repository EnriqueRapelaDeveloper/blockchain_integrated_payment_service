require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  let(:user){ create(:user) }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'loggin' do
    it 'with a correct user data' do
      post :create, params: { user: { email: user.email, password: user.password } }

      expect(response).to have_http_status(:success)
    end

    it 'with invalid parameters' do
      post :create, params: { user: { email: user.email, password: '1234' } }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
