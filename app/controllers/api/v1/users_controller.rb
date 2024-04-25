class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: UserSerializer.new(current_user), status: :ok
  end
end
