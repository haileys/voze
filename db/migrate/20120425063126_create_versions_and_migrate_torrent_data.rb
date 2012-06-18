class CreateVersionsAndMigrateTorrentData < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :name
      t.integer :user_id
      t.integer :torrent_id
      t.string :info_hash
      t.binary :info_bencoded
      t.text :comment

      t.timestamps
    end
    
    add_index :versions, :user_id
    add_index :versions, :torrent_id
    add_index :versions, :info_hash, unique: true
    
    rename_column :peers, :torrent_id, :version_id
    
    Torrent.find_each do |t|
      v = Version.new
      v.name          = "Unknown"
      v.torrent_id    = t.id
      v.user_id       = t.user_id
      v.info_hash     = t.info_hash
      v.info_bencoded = t.info_bencoded
      v.created_at    = t.created_at
      v.updated_at    = t.updated_at
      v.comment       = t.comment
      v.save!
    end
    
    remove_column :torrents, :user_id
    remove_column :torrents, :info_hash
    remove_column :torrents, :info_bencoded
    remove_column :torrents, :comment
    add_column :torrents, :about, :text
  end
end
