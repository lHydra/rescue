class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.post.create(post_params)
    if @post.save 
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :author)
  end
end
