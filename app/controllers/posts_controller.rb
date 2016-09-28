class PostsController < ApplicationController
  load_and_authorize_resource only: [:edit, :destroy]

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
      respond_with(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      respond_with(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_with(@post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :author, :thumb, :remove_thumb)
  end
end
