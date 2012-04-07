class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :code, null: false
      t.integer :inviter_id
      t.integer :invitee_id

      t.timestamps
    end
    
    add_index :invites, :code, unique: true
    add_index :invites, :inviter_id
    add_index :invites, :invitee_id, unique: true
  end
end
