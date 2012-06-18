class Torrent < ActiveRecord::Base
  attr_accessible :name, :about, :category_id
  
  belongs_to :user
  belongs_to :category
  has_many :versions
  has_one :metadata
  
  def to_param
    "#{id}-#{name.parameterize}"
  end
end