class ChangePfms < ActiveRecord::Migration[5.2]
  def change
    rename_column :pfms, :eval, :evl
  end
end
