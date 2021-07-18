class UsersController < ApplicationController

  before_action :set_user, only: [:show] 

  def index
    @users = User.all
    render json: @users
  end

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
    @user = User.find_by_id(params[:id])
    if @user && @user.authenticate(params[:password])
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
