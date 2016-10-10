module Admin
  class UsersController < ApplicationController
    before_filter :find_user, only: [:show, :edit, :update, :destroy]
    def index
      @users = User.all
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to admin_users_path, notice: 'User was successfully created'
      else
        render :new
      end
    end

    def show
    end

    def edit
    end

    def update 
      if @user.update(user_params)
        redirect_to admin_users_path, notice: 'User was successfully updated'
      else
        redner :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: 'User was successfully deleted'
    end

    private

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      attributes = [:email, :password, :password_confirmation, :role]
      params.require(:user).permit(attributes)
    end
  end
end
