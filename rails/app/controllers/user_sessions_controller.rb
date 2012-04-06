class UserSessionsController < ApplicationController
  skip_authorization_check
  
  def new
    authorize! :new, :user_session
  end
  
  def create
    authorize! :create, :user_session
    if user = User.find_by_login(params[:user_session][:login]).try(:authenticate, params[:user_session][:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      @failed_login = true
      render "new"
    end
  end
  
  def destroy
    authorize! :destroy, :user_session
    session[:user_id] = nil
    redirect_to root_path
  end
end
