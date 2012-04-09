module TorrentsHelper
  def personal_announce_url
    announce_url auth_token: current_user.auth_token
  end
end
