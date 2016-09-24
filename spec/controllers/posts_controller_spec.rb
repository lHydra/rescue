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
    let(:user) { create(:user) }
    before(:each) { session[:user_id] = user.id }

    context 'with valid params' do
      it 'should create post' do
        expect{ 
           post :create,
           post: { title: '1', text: '123', author: user.email }
            }.to change(Post, :count).by(1)
          expect(user.posts.last.title).to eq('1')
      end
    end
    
    context 'with invalid params' do
      let(:attr) { attributes_for(:post, title: '') }
      it 'should not create post and render new template' do
        expect{ post :create, post: attr }.to_not change(Post, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do
    context 'when post is create' do
      let(:post) { create(:user_with_posts).posts.last }
      before(:each) do
        get :show, id: post.id
       end

      it { is_expected.to render_template(:show) }
      it { is_expected.to respond_with(200) }
      it 'should return post' do
        expect(assigns[:post]).to eq(post)
      end
    end
  end

  describe 'POST #update' do
    let(:post) { create(:user_with_posts).posts.last }

    context 'with valid params' do
      it 'should update post' do
        put :update, id: post.id, post: { title: 'updated', text: 'new' }
        expect(Post.last.title).to eq('updated')
        expect(Post.last.text).to eq('new')
      end
    end

    context 'with invalid params' do
      it 'should not update post' do
        put :update, id: post.id, post: { title: ''}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET #edit' do
    let(:post) { create(:user_with_posts).posts.last }
    before(:each) { get :edit, id: post.id }

    it { is_expected.to respond_with(200) }
    it { is_expected.to render_template(:edit)}
  end

  describe 'DELETE #destroy' do
    let!(:post) { create(:user_with_posts).posts.last }

    it 'should delete post' do
      expect{ delete :destroy, id: post.id }.to change(Post, :count).by(-1)
    end
  end
end
