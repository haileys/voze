class Torrent < ActiveRecord::Base
  attr_accessor :torrent_file
  attr_accessible :torrent_file, :name
  
  validates :name, length: { in: 2..60 }
  validates :user, presence: true
  validate :torrent_file_is_valid, on: "create", unless: "info_hash && info_bencoded"
  
  before_create :load_data_from_torrent_file, if: "torrent_file"
  
  has_many :peers
  has_many :seeders,  class_name: "Peer", conditions: "`left` = 0"
  has_many :leechers, class_name: "Peer", conditions: "`left` > 0"
  
  belongs_to :user
  
  def torrent_file_is_valid
    if torrent_file
      unless BEncode.load(torrent_file.read)["info"]
        errors[:torrent_file] << "is not valid"
      end
    else
      errors[:torrent_file] << "must not be left blank"
    end
  rescue BEncode::DecodeError
    errors[:torrent_file] << "is not valid"
  end
  
  def load_data_from_torrent_file
    torrent_file.rewind
    data = BEncode.load torrent_file.read
    self.info_hash = Digest::SHA1.hexdigest(data["info"].bencode).upcase
    self.info_bencoded = data["info"].bencode
    self.comment = data["comment"] || ""
  end
  
  def to_param
    "#{id}-#{name.parameterize}"
  end
  
  def optimal_peers
    peers.where("updated_at > ?", 1.hour.ago).order("`left` ASC")
  end
  
  def torrent_file_with(announce_url)
    {
      "info"        => BEncode.load(info_bencoded),
      "comment"     => comment,
      "announce"    => announce_url
    }.bencode
  end
end