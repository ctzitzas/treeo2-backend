class UsersController < ApplicationController

  before_action :set_user, only: [:show, :login]
  before_action :authenticated, only: [:show]

  def show
    render json: @user
  end

  def sign_up
    @user = User.create(user_params)
    if @user.valid?
      render json: @login_response, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    if @user && @user.authenticate(params[:password])
      render json: @login_response, status: :ok
    else
      render json: {error: "Invalid email or password"}
    end
  end

  private

  def set_user 
    begin
      @user = User.find_by(email: params[:email])
    rescue
      render json: {error: "Page not found"}, status: 404
    end
    begin
      @store = Store.find_by(id: @user.store_id)
      @login_response = {
        name: @user.name,
        email: @user.email,
        key: @user.key,
        token: encode({user_id: @user.id}),
        store: {
          name: @store.name,
          address: @store.address,
          suburb: @store.suburb,
          state: @store.state,
          postcode: @store.postcode,
          key: @store.key
        }
        }
    rescue 
      render json: {error: 'set_response failed'}, status: 404
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :key, :user_type, :store_id)
  end
end
