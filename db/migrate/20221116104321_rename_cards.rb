class RenameCards < ActiveRecord::Migration[5.2]
  def change
    rename_column :cards, :customer_id, :cus_id
    rename_column :cards, :card_id, :car_id
  end
end
