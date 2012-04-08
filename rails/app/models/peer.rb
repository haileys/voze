class Peer < ActiveRecord::Base
  attr_accessible :torrent, :user, :peer_id, :ip, :port, :uploaded, :downloaded, :left
  
  belongs_to :user
  belongs_to :torrent
  
  def as_tracker_response
    { ip: ip, port: port, peer_id: peer_id.chars.each_slice(2).map { |x| x.join.to_i(16).chr }.join }
  end
end