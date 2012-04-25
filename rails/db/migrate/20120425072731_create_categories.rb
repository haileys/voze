class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end
    
    add_index :categories, :name, unique: true
    
    add_column :torrents, :category_id, :integer
    add_index :torrents, :category_id
    
    Torrent.update_all ["category_id = ?", Category.create(name: "Misc").id]
  end
end
