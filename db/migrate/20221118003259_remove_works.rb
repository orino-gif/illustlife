class RemoveWorks < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :img1, :string
    remove_column :works, :img2, :string
    remove_column :works, :img3, :string
    remove_column :works, :img4, :string
    remove_column :works, :img5, :string
    remove_column :works, :img6, :string
  end
end
