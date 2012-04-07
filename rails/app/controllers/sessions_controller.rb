class SessionsController < ApplicationController
  skip_authorization_check
  
  layout "sessions"
  
  def new
    authorize! :new, :session
  end
  
  def create
    authorize! :create, :session
    if user = User.find_by_username(params[:session][:username]).try(:authenticate, params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      @failed_login = true
      render "new"
    end
  end
  
  def destroy
    authorize! :destroy, :session
    session[:user_id] = nil
    redirect_to root_path
  end
end
