class RenameUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :accepted, :agree
    rename_column :users, :nickname, :nick
  end
end
