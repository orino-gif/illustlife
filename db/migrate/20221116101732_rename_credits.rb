class RenameCredits < ActiveRecord::Migration[5.2]
  def change
    rename_column :credits, :account_type, :a_type
  end
end
