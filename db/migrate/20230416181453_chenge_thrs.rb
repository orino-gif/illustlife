class ChengeThrs < ActiveRecord::Migration[5.2]
  def up
    remove_column :thrs, :created_at
    remove_column :thrs, :updated_at
  end
  
  def down
    add_column :thrs, :created_at, :datetime
    add_column :thrs, :updated_at, :datetime
  end
end
