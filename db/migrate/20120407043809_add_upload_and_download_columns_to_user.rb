class AddUploadAndDownloadColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :upload, :integer, limit: 8, default: 0, null: false
    add_column :users, :download, :integer, limit: 8, default: 0, null: false
  end
end
