class ApplicationController < ActionController::Base
  check_authorization
  protect_from_forgery

  rescue_from CanCan::AccessDenied, with: :forbidden

protected
  include ApplicationHelper
  
  def forbidden
    if current_user
      render "home/error", status: :forbidden
    else
      redirect_to new_sessions_path
    end
  end
  
  def current_user=(user)
    session[:user_id] = user && user.id
    @current_user = user
  end
end
