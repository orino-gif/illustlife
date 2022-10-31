class ChangeCredits < ActiveRecord::Migration[5.2]
  def change
    rename_column :credits, :branch, :branch
    rename_column :credits, :type, :account_type
    rename_column :credits, :account_number, :number
    rename_column :credits, :account_holder, :holder
  end
end
