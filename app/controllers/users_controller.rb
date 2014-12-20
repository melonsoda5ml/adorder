class UsersController < ApplicationController
	#before_action :set_user, only: [:show, :edit]
	before_action :signed_in_user

  respond_to :html

  def index
    @users = User.all
    respond_with(@users)
  end

  def show
    @user = User.find(params[:id])
    respond_with(@user)
  end

  def new
    @user = User.new
    respond_with(@user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.save
    respond_with(@user)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    respond_with(@user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_with(@user)
  end

  private
		def signed_in_user
			redirect_to root_url unless signed_in?
		end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params[:user]
    end
end
