class RenameTorrentsAboutToTorrentsDescription < ActiveRecord::Migration
  def change
    rename_column :torrents, :about, :description
  end
end
