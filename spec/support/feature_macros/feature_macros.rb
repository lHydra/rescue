module LoginMacros
  def sign_in(user, psw)
    visit login_path
    within('#session') do
      fill_in 'email', with: user.email
      fill_in 'password', with: psw
    end

    click_button 'Log In'
  end
end
