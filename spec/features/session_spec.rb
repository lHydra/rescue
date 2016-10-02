require 'rails_helper'

feature 'Loging in' do
  given!(:user) { create(:user, password: '123', password_confirmation: '123') }

  scenario 'Loging in when user is' do
    visit login_path

    within('#session') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: '123'
    end

    click_button 'Log In'
    expect(page).to have_content 'Welcome'
  end
end
