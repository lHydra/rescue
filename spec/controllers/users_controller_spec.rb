require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'responds seccessfully with an HTTP 200 status code' do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:attr) do
        { email: 'test@mail.ru', password: 'qwerty', password_confirmation: 'qwerty' }
      end

      it 'should create user' do
        expect{ post :create, user: attr }.to change(User, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:attr) do
        { email: 'test@mail.ru', password: 'qwerty', password_confirmation: 'nomatch' }
      end

      it 'should not create user' do
        expect{ post :create, user: attr }.not_to change(User, :count)
        expect(response).to render_template(:new)
      end
    end
  end
end
