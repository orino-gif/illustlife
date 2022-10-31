class ChangeCredits < ActiveRecord::Migration[5.2]
  def change
    rename_column :credits, :branch_name, :branch
    rename_column :credits, :account_number, :number
    rename_column :credits, :account_holder, :holder
  end
end
