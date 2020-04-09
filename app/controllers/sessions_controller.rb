class SessionsController < ApplicationController
  
  def new; end

  def create
    @user = User.find_by(username: user_params[:username])
    if @user&.authenticate(user_params[:password])
      sign_in
      redirect_to users_path
      flash[:success] = 'User saved successfully!'
    else
      flash[:warning] = 'Invalid email/password combination'
      redirect_to new_session_path
    end
  end

  def destroy
    log_out
    redirect_to users_path
  end
  private
  def user_params
    params.permit(:username, :password)
  end
end
