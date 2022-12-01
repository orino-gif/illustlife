class ChangeWorks < ActiveRecord::Migration[5.2]
  def change
    change_column :works, :in_time, :boolean
  end
end
