# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include RackSessionFix
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if current_user
      render json: {
        status: {code: 200, message: 'Logged in sucessfully.'},
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }, status: :ok
    else
      print_error('unauthorized', 'Incorrect credentials', 401)
    end
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: "logged out successfully"
      }, status: :ok
    else
      print_error('unauthorized', 'Incorrect credentials', 401)
    end
  end
end
