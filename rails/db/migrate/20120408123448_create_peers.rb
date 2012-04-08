class CreatePeers < ActiveRecord::Migration
  def change
    create_table :peers do |t|
      t.integer :torrent_id,  null: false
      t.integer :user_id,     null: false
      t.string  :peer_id,     null: false
      t.string  :ip,          null: false
      t.integer :port,        null: false
      t.integer :uploaded,    limit: 8, null: false
      t.integer :downloaded,  limit: 8, null: false
      t.integer :left,        limit: 8, null: false

      t.timestamps
    end
    
    add_index :peers, :torrent_id
    add_index :peers, :peer_id
    add_index :peers, :left
  end
end
