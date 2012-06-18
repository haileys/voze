class ChangeInfoJsonColumnToInfoBencodingColumn < ActiveRecord::Migration
  def change
    rename_column :torrents, :info_json, :info_bencoded
    change_column :torrents, :info_bencoded, :binary
  end
end
