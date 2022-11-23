class CreateExpors < ActiveRecord::Migration[5.2]
  def change
    create_table :expors do |t|
      t.integer :cntri_id
      t.string :expo_img
      t.timestamp :created_at
    end
  end
end
