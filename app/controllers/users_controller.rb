class UsersController < ApplicationController

  before_action :set_user, only: [:show]
  before_action :authenticated, only: [:show]

  def show
    render json: @user
  end

  def sign_up
    @user = User.create(user_params)
    if @user.valid?
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      render json: {message: 'Sucessful login', token: encode({user_id: @user.id})}, status: :ok
    else
      render json: {error: "Invalid username or password"}
    end
  end

  private

  def set_user 
    begin
      @user = User.find(params[:id])
    rescue
      render json: {error: "Page not found"}, status: 404
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :key, :user_type, :store_id)
  end

end