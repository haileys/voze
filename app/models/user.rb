class User < ActiveRecord::Base
  attr_accessor :invite_code
  
  attr_accessible :username, :password, :password_confirmation, :email, :invite_code
  attr_readonly :username, :invite_code
  
  has_secure_password
  
  validates :username, length: { in: 2..32 }, format: { with: /\A[a-z0-9_ ]*\z/i, message: "may only contain letters, numbers, spaces and underscores" }, uniqueness: true
  validates :password, length: { minimum: 4 }, if: "password"
  validates :email, length: { maximum: 100 }, email: true, uniqueness: true
  
  before_create :set_auth_token
  
  validate :check_invite_code, on: "create"
  before_create :set_invite_according_to_invite_code
  
  has_many :invites, foreign_key: "inviter_id"
  has_many :invitees, through: :invites
  has_one :invite, foreign_key: "invitee_id"
  has_one :inviter, through: :invite
  
  def check_invite_code
    unless Invite.unused.find_by_code invite_code
      errors[:invite_code] << "is not valid"
    end
  end
  
  def set_invite_according_to_invite_code
    self.invite = Invite.unused.find_by_code invite_code
  end
  
  def generate_password_reset_token!
    self.password_reset_token = SecureRandom.hex 24
    save!
  end
  
  def set_auth_token
    self.auth_token = SecureRandom.hex 16
  end
  
  def to_param
    username
  end
  
  def gravatar_url(size = nil)
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest email}".tap do |url|
      url << "?size=#{size}" if size
    end
  end
  
  def ratio
    return 0 if download.zero?
    upload.to_f / download.to_f
  end
  
  def required_ratio
    free_download = AppConfig.required_ratio.free_download
    capped_at = AppConfig.required_ratio.capped_at
    max = AppConfig.required_ratio.max
    
    gb_down = download / 1.gigabyte.to_f
    
    if gb_down < free_download
      0
    elsif gb_down < capped_at
      max * Math.sqrt(2 * capped_at * gb_down - gb_down ** 2) / capped_at
    else
      max
    end
  end
end
