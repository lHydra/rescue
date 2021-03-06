module Admin
  class PostsController < ApplicationController
    load_and_authorize_resource
    before_filter :find_post, only: [:show, :edit, :update, :destroy]
    respond_to :html, :js
    
    def index
      @posts = Post.all
    end

    def new
      @post = Post.new
    end

    def create
      @user = current_user
      @post = @user.posts.create(post_params)
      if @post.save
        redirect_to admin_posts_path, notice: 'Article was created'
      else
        render :new
      end
    end

    def show
    end

    def edit
    end

    def update
      if @post.update(post_params)
        redirect_to admin_posts_path, notice: 'Article was successfully updated'
      else
        render :edit
      end
    end

    def destroy
      @post.destroy
      respond_with(@post)
    end

    private

    def find_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :text, :author, :thumb, :remove_thumb)
    end
  end
end
