class AddApprovaldayRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :approval_day, :datetime
    add_column :requests, :delivery_time, :integer
  end
end
