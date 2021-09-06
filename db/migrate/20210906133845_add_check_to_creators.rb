class AddCheckToCreators < ActiveRecord::Migration[5.2]
  def change
    add_column :creators, :checkbox, :boolean
  end
end
