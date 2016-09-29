require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception

  private 

  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def posts
    @posts = Post.limit(3)
  end
  
  helper_method :current_user
  helper_method :posts
end
