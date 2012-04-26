class CreateMetadataMusic < ActiveRecord::Migration
  def change
    add_column :metadata, :track_listing, :text
    add_column :metadata, :release_type, :string
    add_column :metadata, :release_year, :integer
    add_column :metadata, :artist, :string
  end
end
