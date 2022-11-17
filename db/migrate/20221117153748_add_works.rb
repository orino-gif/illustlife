class AddWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :images, :json
  end
end
