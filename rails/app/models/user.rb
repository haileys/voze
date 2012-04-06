class User < ActiveRecord::Base
  acts_as_authentic
  
  attr_accessible :login, :password, :email
  attr_readonly :login
  
  validates :login, length: { in: 2..32 }
end
