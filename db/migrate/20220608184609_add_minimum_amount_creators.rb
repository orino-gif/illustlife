class AddMinimumAmountCreators < ActiveRecord::Migration[5.2]
  def change
    add_column :creators, :minimum_amount, :integer, default:1000
  end
end
