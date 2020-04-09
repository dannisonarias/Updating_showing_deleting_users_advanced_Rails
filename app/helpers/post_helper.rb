module PostHelper
  # require user to be logged in for access
  def require_login
    unless current_user
      flash[:warning] = 'You must be logged in to access this section'
      redirect_to new_session_path # halts request cycle
    end
  end

  def show_author(post)
    current_user
    logged_in? ? post.user.username : 'hidden'
  end
end
