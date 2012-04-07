class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.include? "@"
      record.errors[attribute] << "doesn't look like a valid email address"
    end
  end
end

class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation, :email
  attr_readonly :username
  
  validates :username, length: { in: 2..32 }, uniqueness: true
  validates :password, length: { minimum: 4 }, confirmation: true
  validates :email, length: { in: 5..100 }, email: true, uniqueness: true
  
  has_secure_password
  
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
