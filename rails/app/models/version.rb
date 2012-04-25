class Version < ActiveRecord::Base
  attr_accessor :torrent_file, :expected_announce
  attr_accessible :torrent_file, :name
  
  validates :name, length: { in: 2..60 }
  validates :user, presence: true
  validate :torrent_file_is_valid, on: "create", unless: "info_hash && info_bencoded"
  
  before_create :load_data_from_torrent_file, if: "torrent_file"
  
  has_many :peers, conditions: proc { ["updated_at > ?", 30.minutes.ago] }
  belongs_to :torrent
  belongs_to :user
  
  def seeders
    peers.where "`left` = 0"
  end
  
  def leechers
    peers.where "`left` > 0"
  end
  
  def size
    files.map { |name,size| size }.reduce(:+)
  end
  
  def files
    data = BEncode.load info_bencoded
    if data["files"]
      Hash[data["files"].map { |f| [f["name"], f["length"]] }]
    else
      { data["name"] => data["length"] }
    end
  end
  
  def filetypes
    files.keys.map { |name| name.split(".").last }.uniq
  end
  
  def torrent_file_is_valid
    if torrent_file
      data = BEncode.load(torrent_file.read)
      if data["info"]
        if expected_announce and expected_announce != data["announce"]
          errors[:torrent_file] << "has an incorrect announce URL"
        end
      else
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