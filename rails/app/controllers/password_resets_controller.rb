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
  end
  
  def update
    @user = User.find_by_password_reset_token! params[:id]
    @user.password = params[:user][:password]
    @user.password_reset_token = nil
    if @user.save
      self.current_user = @user
    else
      @errors = @user.errors.full_messages
      render "edit"
    end
  end
end
