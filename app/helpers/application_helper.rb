module ApplicationHelper
  def current_user
    @current_user ||= begin
      if session[:user_id]
        User.find session[:user_id]
      elsif params[:auth_token]
        User.find_by_auth_token params[:auth_token]
      end
    end
  end
  
  def personal_announce_url
    announce_url auth_token: current_user.auth_token
  end
end
