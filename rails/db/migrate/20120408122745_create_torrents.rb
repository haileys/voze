class CreateTorrents < ActiveRecord::Migration
  def change
    create_table :torrents do |t|
      t.string  :name,      null: false
      t.integer :user_id,   null: false
      t.string  :info_hash, null: false
      t.text    :info_json, null: false
      t.text    :comment,   null: false

      t.timestamps
    end
    
    add_index :torrents, :info_hash, unique: true
    add_index :torrents, :user_id
  end
end
