require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'responds seccessfully with an HTTP 200 status code' do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    let!(:user) do
      User.create!(email: 'test@mail.ru', password: '111', password_confirmation: '111')
    end

    context 'when valid user' do
      it 'possible log in' do
        post :create, { email: user.email, password: '111' }
        expect(response).to redirect_to(root_url)
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context 'when invalid user' do
      it 'unpossible log in' do 
        post :create, { email: user.email, password: 'nomatch' }
        expect(response).to render_template(:new)
      end
    end
  end
end
