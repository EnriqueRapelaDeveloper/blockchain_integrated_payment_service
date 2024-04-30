require 'rails_helper'

RSpec.describe Api::V1::FiatPaymentsController, type: :controller do
  let(:user){ create(:user) }
  let!(:fiat_payment) { create(:fiat_payment, user:) }

  before do
    sign_in(user)
  end

  after do
    sign_out(user)
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
      post :create, params: { fiat_payment: { amount_cents: 10_000 } }

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(body['data']['id']).to eq user.fiat_payments.last.uuid
    end

    it 'with invalid parameters' do
      post :create, params: { fiat_payment: { amount_cents: -10_000 } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  # Paid instant fee for payments and trades
  describe '#CREATE(logic A)' do
    before do
      post :create, params: { fiat_payment: { amount_cents: 10_000 } }

      body = JSON.parse(response.body)

      @fiat_payment = user.fiat_payments.find_by!(uuid: body['data']['id'])
      @trade = user.trades.last
      @blockchain_payment = user.blockchain_payments.last
    end

    it 'with correct payment amount' do
      expect(@fiat_payment.amount_cents).to eq 10_000 - (10_000 * 0.01)
    end

    it 'with correct payment fee amount' do
      expect(@fiat_payment.fee.amount_cents).to eq 10_000 * 0.01
      expect(@trade.fee.paid).to eq true
    end

    it 'with correct trade fee amount' do
      expect(@trade.fee.amount_cents).to eq @fiat_payment.amount_cents * 0.01
      expect(@trade.fee.paid).to eq true
    end

    it 'with correct trade amount' do
      expect(@trade.original_amount_cents).to eq @fiat_payment.amount_cents - (@fiat_payment.amount_cents * 0.01)
      expect(@trade.final_amount_cents).to eq (@trade.original_amount_cents * 1.20).to_i
    end

    it 'with correct blockchain fee amount' do
      expect(@blockchain_payment.fee.amount_cents).to eq (@trade.final_amount_cents * 0.01).to_i
      expect(@blockchain_payment.fee.paid).to eq true
    end

    it 'with correct blockchain amount' do
      expect(@blockchain_payment.amount_cents).to eq (@trade.final_amount_cents - (@trade.final_amount_cents * 0.01)).to_i
    end
  end

  # Paid instant fee for trade and save for payments
  describe '#CREATE(logic B)' do
    before do
      user.fee_configuration.update(payments: false)
      post :create, params: { fiat_payment: { amount_cents: 10_000 } }

      body = JSON.parse(response.body)

      @fiat_payment = user.fiat_payments.find_by!(uuid: body['data']['id'])
      @trade = user.trades.last
      @blockchain_payment = user.blockchain_payments.last
    end

    it 'with correct payment amount' do
      expect(@fiat_payment.amount_cents).to eq 10_000
    end

    it 'with correct payment fee amount' do
      expect(@fiat_payment.fee.amount_cents).to eq 10_000 * 0.01
      expect(@fiat_payment.fee.paid).to eq false
    end

    it 'with correct trade fee amount' do
      expect(@trade.fee.amount_cents).to eq @fiat_payment.amount_cents * 0.01
      expect(@trade.fee.paid).to eq true
    end

    it 'with correct trade amount' do
      expect(@trade.original_amount_cents).to eq @fiat_payment.amount_cents - (@fiat_payment.amount_cents * 0.01)
      expect(@trade.final_amount_cents).to eq (@trade.original_amount_cents * 1.20).to_i
    end

    it 'with correct blockchain fee amount' do
      expect(@blockchain_payment.fee.amount_cents).to eq (@trade.final_amount_cents * 0.01).to_i
      expect(@blockchain_payment.fee.paid).to eq false
    end

    it 'with correct blockchain amount' do
      expect(@blockchain_payment.amount_cents).to eq @trade.final_amount_cents
    end
  end
end
