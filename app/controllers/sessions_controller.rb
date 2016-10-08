class SessionsController < ApplicationController
  def new
    @user = User.find_by_email(params[:email])
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.role == 'admin'
        redirect_to admin_path, notice: 'Logged in!'
      else
        redirect_to root_path, notice: 'Welcome!'
      end
    elsif request.env['omniauth.auth']
      user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Welcome!'
    else
      flash.now.alert = 'Email or password is invalid'
      render 'new'
    end 
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out!'
  end
end
