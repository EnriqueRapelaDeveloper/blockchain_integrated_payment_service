require 'rails_helper'

RSpec.describe Api::V1::FiatPaymentsController, type: :controller do
  let(:user){ create(:user) }
  let!(:fee_configuration) { create(:fee_configuration, user: user) }
  let!(:fiat_payment) { create(:fiat_payment, user: user) }

  before do
    sign_in(user)
  end

  describe '#INDEX' do
    it 'returns fiat payments' do
      get :index

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(body['data'].count).to eq 1
    end
  end

  describe '#SHOW' do
    it 'returns specific fiat payment' do
      get :show, params: { uuid: fiat_payment.uuid }

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(body['data']['id']).to eq fiat_payment.uuid
    end

    it 'returns error with a invalid uuid' do
      get :show, params: { uuid: 'invalid-uuid' }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe '#CREATE' do
    it 'with a valid parameters' do
      post :create, params: { fiat_payment: { amount_cents: 10000 } }

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(body['data']['id']).to eq user.fiat_payments.last.uuid
    end

    it 'with invalid parameters' do
      post :create, params: { fiat_payment: { amount_cents: -10000 } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
