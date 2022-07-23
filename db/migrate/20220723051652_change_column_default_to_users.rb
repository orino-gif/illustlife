class ChangeColumnDefaultToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :creators, :recommended_amount, from: 3000, to: 5000
  end
end
