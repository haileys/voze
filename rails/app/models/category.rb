class Category < ActiveRecord::Base
  attr_accessible :name
  
  validates :name,
    length: { in: 3..40 },
    format: { with: /\A[a-z0-9 _\-]+\z/i, message: "may only contain letters, numbers, spaces, underscores and hyphens" },
    uniqueness: true
  
  has_many :torrents
  
  def to_param
    "#{id}-#{name.parameterize}"
  end
end
