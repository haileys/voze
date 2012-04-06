class ApplicationController < ActionController::Base
  check_authorization
  protect_from_forgery

  rescue_from CanCan::AccessDenied, with: :forbidden

protected
  include ApplicationHelper
  
  def forbidden
    if current_user
      # uh show an unauthorized page or something
    else
      redirect_to new_user_sessions_path
    end
  end
end
