class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :current_user
  helper_method :logged_in?

  private

  def sign_in
    renew_tokens
    # Remembers a user in the browser cookies for use in persistent sessions.
    cookies.permanent[:remember_token] = @user.remember_digest
  end

  def renew_tokens
    # Give the user a new remember token
    @user.remember
    # Save new token to the model
    @user.save
  end

  # Logs out the current user.
  def log_out
    # destroys cookies token
    cookies[:remember_token] = nil
    @current_user = nil
  end

  # Returns the current logged-in user (if any).
  def current_user
    remember_token = cookies[:remember_token]
    @current_user ||= User.find_by(remember_digest: remember_token)
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !@current_user.nil?
  end
end
