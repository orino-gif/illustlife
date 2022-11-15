class RenameCreators < ActiveRecord::Migration[5.2]
  def change
    rename_column :creators, :header, :hdr
    rename_column :creators, :twitter, :twtr
    rename_column :creators, :instagram, :insta
    rename_column :creators, :youtube, :yt
  end
end
