require 'rails_helper'

feature 'accesses the dashborad' do
  given!(:admin) { create(:user, password: '123', password_confirmation: '123', role: 'admin') }
  given!(:user) { create(:user, password: '123', password_confirmation: '123') }

  scenario 'accesses admin to dashboard' do
    sign_in(admin, '123')
    expect(current_path).to eq(admin_path)

    within('h1') do
      expect(page).to have_content('Admin Panel')
    end

    expect(page).to have_content('Manage Users')
    expect(page).to have_content('Manage Articles')
  end

  scenario 'its denied access when not admin or not logged' do
    sign_in(user, '123')
    expect(page).to have_content('Welcome')

    visit admin_path
    expect(page).to have_content('Access Denied!')
  end
end

feature 'article managment' do
  given!(:admin) { create(:user, password: '123', password_confirmation: '123', role: 'admin') }
  before(:each) { sign_in(admin, '123') }
  
  scenario 'adds article' do
    click_link 'Manage Articles'

    expect(current_path).to eq(admin_posts_path)
    expect{
      click_link 'New Article'
      fill_in 'Title', with: 'It is a new post'
      fill_in 'Text', with: 'Some text body'
      click_button 'Create Article'
    }.to change(Post, :count).by(1)

    expect(current_path).to eq(admin_posts_path)
    expect(page). to have_content('It is a new post')
  end
end
