class UsersController < ApplicationController

  before_action :set_user, only: [:show] 

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  private

  def set_user 
    begin
      @user = User.find(params[:id])
    rescue
      render json: {error: "Page not found"}, status: 404
    end
  end

end
