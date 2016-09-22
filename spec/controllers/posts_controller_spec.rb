require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    before(:each) { get :index }

    it { is_expected.to render_template(:index) }
    it { is_expected.to respond_with(200) }

    it 'populates an array of posts' do
      posts = create(:user_with_posts).posts
      expect(assigns(:posts)).to eq(posts)
    end
  end

  describe 'GET #new' do
    before(:each) { get :new }
    
    it { is_expected.to render_template(:new) }
    it { is_expected.to respond_with(200) }
  end

  describe 'POST #create' do
    let!(:user) { create(:user) }

    context 'with valid params' do
      it 'should create post' do
        expect{ 
           post :create,
           user_id: user.id,
           post: { title: '1', text: '123', author: user.email }
            }.to change(Post, :count).by(1)
          expect(user.posts.last.title).to eq('1')
      end
    end
  end
end
