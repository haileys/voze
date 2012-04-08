class Torrent < ActiveRecord::Base
  has_many :peers
  has_many :seeders,  class_name: "Peer", conditions: "`left` = 0"
  has_many :leechers, class_name: "Peer", conditions: "`left` > 0"
  
  belongs_to :user
  
  def self.from_bencoded_file(bencoded)
    data = BEncode.load bencoded
    Torrent.new.tap do |torrent|
      torrent.info_hash = Digest::SHA1.hexdigest(data["info"].bencode).upcase
      torrent.info_json = data["info"].to_json
    end
  end
  
  def optimal_peers
    peers.where("updated_at > ?", 1.hour.ago).order("`left` ASC")
  end
end