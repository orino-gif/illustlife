class RenameWorks < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :del_time, :d_time
    rename_column :works, :is_in_time, :in_time
    rename_column :works, :is_rework, :rework
    rename_column :works, :del_img, :img1
    rename_column :works, :del_img2, :img2
    rename_column :works, :del_img3, :img3
    rename_column :works, :del_img4, :img4
    rename_column :works, :del_img5, :img5
    rename_column :works, :del_img6, :img6
  end
end
