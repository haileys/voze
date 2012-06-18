class UsersController < ApplicationController
  load_and_authorize_resource find_by: :username
  
  def new
    @user.invite_code = params[:invite_code]
    render layout: "sessions"
  end
  
  def create
    @user = User.new params[:user]
    if @user.save
      self.current_user = @user
      redirect_to root_path
    else
      @errors = @user.errors.full_messages
      render "new", layout: "sessions"
    end
  end
end
