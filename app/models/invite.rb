class Invite < ActiveRecord::Base
  belongs_to :inviter, class_name: "User"
  belongs_to :invitee, class_name: "User"

  before_create :generate_code
  
  validates :code, uniqueness: true
  
  scope :unused, where("invitee_id is null")
  
  def generate_code
    self.code = SecureRandom.hex 8
  end
end
