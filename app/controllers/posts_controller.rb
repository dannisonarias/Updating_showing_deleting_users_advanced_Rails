class PostsController < ApplicationController
  include PostHelper
  # require user to be logged in for access to any methods
  before_action :require_login, except: [:index]

  def index
    @post = Post.all
  end

  def create
    @post = Post.new(post_params)
    # assign the logged in users id to the post model
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = 'Content Successfully Created'
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def new
    @post = Post.new
  end

  def post_params
    params.require(:post).permit(:title, :body).merge(user: current_user)
  end
end
