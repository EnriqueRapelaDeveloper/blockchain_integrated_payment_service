require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user){ create(:user) }

  describe 'index' do
    it 'with a correct sign in' do
      sign_in(user)

      get :index

      expect(response).to have_http_status(:success)
    end

    it 'with a correct sign in' do
      get :index

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
