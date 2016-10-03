require 'rails_helper'

feature 'Loging in' do
  given!(:user) { create(:user, password: '123', password_confirmation: '123') }

  scenario 'Loging in when user is' do
    sign_in(user, '123')
    expect(page).to have_content 'Welcome'
  end
end
