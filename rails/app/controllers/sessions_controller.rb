class SessionsController < ApplicationController
  skip_authorization_check
  
  layout "sessions"
  
  def new
    
  end
  
  def create
    authorize! :create, :session
    if user = User.find_by_username(params[:session][:username]).try(:authenticate, params[:session][:password])
      self.current_user = user
      redirect_to params[:redirect_to] || root_path
    else
      @failed_login = true
      render "new"
    end
  end
  
  def destroy
    authorize! :destroy, :session
    self.current_user = nil
    redirect_to root_path
  end
end
