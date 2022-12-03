class ChangeWorks < ActiveRecord::Migration[5.2]
  def up
    change_column :works, :in_time, :boolean
  end
  
  def down
    change_column :works, :in_time, :datetime
  end
end
