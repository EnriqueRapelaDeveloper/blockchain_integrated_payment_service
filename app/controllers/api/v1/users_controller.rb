class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!

  # GET /api/v1/me
  def index
    render json: UserSerializer.new(current_user), status: :ok
  end
end
