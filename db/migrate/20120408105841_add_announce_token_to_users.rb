class AddAnnounceTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_token, :string
    add_index :users, :auth_token
    
    User.find_each do |user|
      user.set_auth_token
      user.save!
    end
  end
end
