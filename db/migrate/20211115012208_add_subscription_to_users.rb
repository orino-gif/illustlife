class AddSubscriptionToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :subscription_id, :string
    add_column :users, :premium, :boolean, default: false, null: false
  end
end
