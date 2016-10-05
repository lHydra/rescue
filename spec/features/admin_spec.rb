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

  scenario 'update article' do
    post = create(:post, title: 'Some Title')
    click_link 'Manage Articles'
    click_link "#{post.id}"

    fill_in 'Title', with: 'Update Title'
    click_button 'Create Article'

    expect(page).to have_content('updated')
  end
end

feature 'user managment' do
  given!(:admin) { create(:user, password: '123', password_confirmation: '123', role: 'admin') }
  before(:each) { sign_in(admin, '123') }

  scenario 'adds user' do
    click_link 'Manage Users'

    expect(current_path).to eq(admin_users_path)
    expect{
      click_link 'Add User'
      fill_in 'Email', with: 'somemail@mail.ru'
      fill_in 'Password', with: '123'
      fill_in 'Password confirmation', with: '123'
      click_button 'Create User'
    }.to change(User, :count).by(1)

    expect(current_path).to eq(admin_users_path)
    expect(page).to have_content('somemail@mail.ru')
  end

  scenario 'delete user' do
    create(:user, email: 'mail@mails.ru')
    click_link 'Manage Users'
    click_link 'mail@mails.ru'
    
    expect{
      click_link 'Delete User'
    }.to change(User, :count).by(-1)  
  end

  scenario 'update user' do
    create(:user, email: 'mail@mails.ru')
    click_link 'Manage Users'
    click_link 'mail@mails.ru'
    click_link 'Update User'

    fill_in 'Email', with: 'newmail@mail.ru'
    click_button 'Create User'

    expect(page).to have_content('updated')
  end
end
