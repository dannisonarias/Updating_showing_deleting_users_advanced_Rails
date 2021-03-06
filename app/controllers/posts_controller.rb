class PostsController < ApplicationController
  include PostHelper
  # require user to be logged in for access to any methods
  before_action :require_login, except: [:index]

  def index
    # includes user to avoid n+1 problem in the view
    @post = Post.all.includes(:user)
  end

  def create
    @post = Post.new(post_params)
    # assign the logged in users id to the post model
    @post.user_id = current_user.id
    @post.author = current_user.username
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
