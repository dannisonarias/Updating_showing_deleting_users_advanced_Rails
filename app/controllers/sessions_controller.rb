class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: user_params[:username])
    if @user && @user.authenticate(user_params[:password])
      sign_in
      redirect_to users_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to users_path
  end

  def user_params
    params.permit(:username,:password)
  end
end