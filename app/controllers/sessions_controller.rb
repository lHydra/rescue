class SessionsController < ApplicationController
  before_filter :find_user, only: [:new, :create]

  def new
  end

  def create
    if request.env['omniauth.auth']
      attr_from_oauth = request.env['omniauth.auth']
      @user = User.from_omniauth(attr_from_oauth)
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Welcome!'
    elsif @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      if @user.role == 'admin'
        redirect_to admin_path, notice: 'Logged in!'
      else
        redirect_to root_path, notice: 'Welcome!'
      end
    else
      flash.now.alert = 'Email or password is invalid'
      render 'new'
    end 
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out!'
  end

  private

  def find_user
    @user = User.find_by_email(params[:email])
  end
end
