module ControllerMacros
  def login_as_admin
    user = create(:user, role: 'admin')
    session[:user_id] = user.id
  end

  def login_as_user
    user = create(:user)
    session[:user_id] = user.id
    user
  end
end
