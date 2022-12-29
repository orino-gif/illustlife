class ChangeExpors2 < ActiveRecord::Migration[5.2]
  def change
    add_reference :expors, :msg
    add_column :expors, :who_id, :integer
  end
end
