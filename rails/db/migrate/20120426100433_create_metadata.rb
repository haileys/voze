class CreateMetadata < ActiveRecord::Migration
  def change
    create_table :metadata do |t|
      t.integer :torrent_id
      t.string :type

      t.timestamps
    end
    
    add_index :metadata, :torrent_id, unique: true
  end
end
