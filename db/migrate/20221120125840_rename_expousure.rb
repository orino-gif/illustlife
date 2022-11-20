class RenameExpousure < ActiveRecord::Migration[5.2]
  def change
    rename_column :exposures, :contributor_id, :cntri_id
    rename_column :exposures, :exposed_img, :expo_img
  end
end
