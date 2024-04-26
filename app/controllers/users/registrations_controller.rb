# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix
  respond_to :json

  def create
    ActiveRecord::Base.transaction do
      super
    end
  rescue ActiveRecord::RecordInvalid => e
    print_error('invalid_record', e.message, 422)
  end

  private

  def respond_with(resource, _opts = {})
    if request.method == "POST" && resource.persisted?
      update_fee_configuration(resource)
      render json: {
        status: {code: 200, message: "Signed up sucessfully."},
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }, status: :ok
    else
      print_error('invalid_record', resource.errors.full_messages.to_sentence, 422)
    end
  end

  def update_fee_configuration(resource)
    return unless fee_configuration_params

    resource.fee_configuration.update!(fee_configuration_params)
  end

  def fee_configuration_params
    params['user']['fee_configuration']&.permit(:payments, :payments_percentage, :trades, :trades_percentage)
  end
end
