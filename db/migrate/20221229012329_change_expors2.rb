class ChangeExpors2 < ActiveRecord::Migration[5.2]
  def change
    add_reference :expors, :msg
    add_column :expors, :who, :string
    change_column_default :expors, :fee, from: nil, to: 0
    add_column :expors, :e_dl, :date
    add_column :expors, :cmt, :string
  end
end
