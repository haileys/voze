class PasswordResetsController < ApplicationController
  skip_authorization_check
  layout "sessions"
  
  def create
    user = User.find_by_username(params[:password_reset][:username]) || User.find_by_email(params[:password_reset][:username])
    if user
      user.generate_password_reset_token!
      PasswordResetsMailer.reset_email(user).deliver
    end
  end
  
  def show
    @user = User.find_by_password_reset_token! params[:id]
    @user.password_reset_token = nil
    self.current_user = @user
    # @TODO - the idea is we'll log the user in here and redirect them to the
    # change password page in their account settings
    redirect_to root_path
  end
end
