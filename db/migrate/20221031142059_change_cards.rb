class ChangeCards < ActiveRecord::Migration[5.2]
  def change
    rename_column :cards, :id, :user_id
  end
end
