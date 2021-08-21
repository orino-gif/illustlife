class AddUserIdToCreators < ActiveRecord::Migration[5.2]
  def change
    add_column :creators, :user_id, :integer
  end
end
