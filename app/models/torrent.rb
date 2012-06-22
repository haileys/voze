class Torrent < ActiveRecord::Base
  attr_accessible :name, :description, :category_id
  
  belongs_to :user
  belongs_to :category
  has_many :versions
  has_one :metadata
  
  accepts_nested_attributes_for :versions, limit: 1
  
  def to_param
    "#{id}-#{name.parameterize}"
  end
end