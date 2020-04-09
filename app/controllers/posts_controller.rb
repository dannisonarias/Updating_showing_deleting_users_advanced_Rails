class PostsController < ApplicationController
  include PostHelper
  # require user to be logged in for access to any methods
  before_action :require_login
  
  def index
    @post = Post.all
  end

  def create
    @post = Post.new(post_params)
  end

  def new
    @post = Post.new
  end

  def post_params
    params.require(:post).permit(:title,:body)
  end
end
