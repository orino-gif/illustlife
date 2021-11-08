class AddAchievementToCreators < ActiveRecord::Migration[5.2]
  def change
    add_column :creators, :average_delivery, :float
    add_column :creators, :number_deliveries, :integer
    add_column :creators, :deadline_rate, :integer
  end
end
