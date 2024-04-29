class Api::V1::FiatPaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_fiat_payments, only: %i[index]
  before_action :set_fiat_payment, only: %i[show]

  # GET /api/v1/fiat_payments
  def index
    render json: FiatPaymentSerializer.new(@fiat_payments), status: 200
  end

  # GET /api/v1/fiat_payments/:uid
  def show
    render json: FiatPaymentSerializer.new(@fiat_payment), status: 200
  end

  # POST /api/v1/fiat_payments
  def create
    fiat_payment = current_user.fiat_payments.new(fiat_payment_params)

    if fiat_payment.valid?
      fiat_payment.save
      render json: FiatPaymentSerializer.new(fiat_payment), status: 200
    else
      print_multiple_errors('invalid_record', 422, fiat_payment.errors)
    end
  rescue TradeError => e
    print_multiple_errors(e.error_code, 422, [e])
  end

  private

  def set_fiat_payments
    @fiat_payments = current_user.fiat_payments
  end

  def set_fiat_payment
    @fiat_payment = current_user.fiat_payments.find_by!(uuid: params[:uuid])
  rescue ActiveRecord::RecordNotFound
    print_error('record_not_found', 'The identifier provided is wrong', 404, params[:uuid])
  end

  def fiat_payment_params
    params.require(:fiat_payment).permit(:amount_cents)
  end
end
