class Peer < ActiveRecord::Base
  attr_accessible :version, :user, :peer_id, :ip, :port, :uploaded, :downloaded, :left
  
  belongs_to :user
  belongs_to :version
  
  after_update :update_users_uploaded_downloaded
  
  def update_users_uploaded_downloaded
    user.upload += [uploaded - uploaded_was, 0].max if uploaded_changed?
    user.download += [downloaded - downloaded_was, 0].max if downloaded_changed?
    user.save
  end
  
  def as_tracker_response
    { ip: ip, port: port, peer_id: peer_id.chars.each_slice(2).map { |x| x.join.to_i(16).chr }.join }
  end
end