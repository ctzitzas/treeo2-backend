class UsersController < ApplicationController

  before_action :authenticated, only: [:index, :update, :destroy]
  before_action :set_user, only: [:login]
  before_action :set_login, only: [:login]
  

  def index
    render json: {index: 'Success'}, status: :ok
  end

  def update
    begin
      @user.update(name: params[:name], email: params[:email])
      render json: {name: @user.name, email: @user.email, token:encode({user_id: @user.id})}, status: :ok
    rescue
      render json: {update: "Unable to update"}, status: 404
    end
  end

  def destroy
    begin
      @user.destroy
      render json: {destroy: 'Success'}, status: :ok
    rescue
      render json: {destroy: "Unable to delete"}, status: 404
    end
  end

  def sign_up
    @user = User.create(user_params)
    if @user.valid?
      render json: { login: 'Success' }, status: :created
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
      render json: {error: "User not found"}, status: 404
    end
  end

  def set_login 
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
