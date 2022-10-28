class ChangeCreators < ActiveRecord::Migration[5.2]
  def change
    rename_column :creators, :recommended_amount, :recommend
    rename_column :creators, :minimum_amount, :minimum
    rename_column :creators, :working_days, :working
    # rename_column :creators, :number_of_works, :painting
    # rename_column :creators, :deadline_strict_adherence_rate, :deadline
    # rename_column :creators, :reply_rate, :reply
    rename_column :creators, :request_acceptance_permission, :opening
    # rename_column :creators, :creator_points, :points
    # rename_column :creators, :evaluation_points, :evaluation
    # rename_column :creators, :withdrawal_amount, :withdrawal
    
    remove_column :creators, :number_of_works, :integer
    remove_column :creators, :deadline_strict_adherence_rate, :float
    remove_column :creators, :reply_rate, :float
    remove_column :creators, :creator_points, :integer
    remove_column :creators, :evaluation_points, :integer
    remove_column :creators, :earnings, :integer
    remove_column :creators, :withdrawal_amount, :integer
    
    remove_column :creators, :number_of_request, :integer
    remove_column :creators, :number_of_approval, :integer
    remove_column :creators, :average_delivery_time, :float
  end
end
