class SessionsController < ApplicationController
  skip_authorization_check
  
  layout "sessions"
  
  def new
    
  end
  
  def create
    authorize! :create, :session
    if user = User.find_by_username(params[:session][:username]).try(:authenticate, params[:session][:password])
      self.current_user = user
      respond_to do |f|
        f.html { redirect_to params[:redirect_to] || root_path }
        f.json { render json: { success: true } }
      end
    else  
      @failed_login = true
      respond_to do |f|
        f.html { render "new" }
        f.json { render json: { success: false } }
      end
    end
  end
  
  def destroy
    authorize! :destroy, :session
    self.current_user = nil
    redirect_to root_path
  end
end
