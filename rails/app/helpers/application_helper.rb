module ApplicationHelper
  def current_session
    @current_session ||= UserSession.find
  end
  
  def current_user
    current_session and current_session.user
  end
end
