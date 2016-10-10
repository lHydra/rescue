class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Thank you for signing in!'
    else
      render :new
    end
  end

  private

  def user_params
    attributes = [:email, :password, :password_confirmation, :role]
    params.require(:user).permit(attributes)
  end
end
