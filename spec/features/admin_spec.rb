require 'rails_helper'

feature 'accesses the dashborad' do
  given!(:admin) { create(:user, password: '123', password_confirmation: '123', role: 'admin') }
  given!(:user) { create(:user, password: '123', password_confirmation: '123') }

  scenario 'accesses admin to dashboard' do
    visit login_path

    within('#session') do
      fill_in 'Email', with: admin.email
      fill_in 'password', with: '123'
    end

    click_button 'Log In'
    expect(current_path).to eq(admin_path)

    within('h1') do
      expect(page).to have_content('Admin Panel')
    end

    expect(page).to have_content('Manage Users')
    expect(page).to have_content('Manage Articles')
  end

  scenario 'its denied access when not admin or not logged' do
    visit login_path

    within('#session') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: '123'
    end

    click_button 'Log In'
    expect(page).to have_content('Welcome')
    visit admin_path

    expect(page).to have_content('Access Denied!')
  end
end
