class Torrent < ActiveRecord::Base
  attr_accessible :name, :about
  
  belongs_to :user
  belongs_to :category
  has_many :versions
  
  def to_param
    "#{id}-#{name.parameterize}"
  end
end