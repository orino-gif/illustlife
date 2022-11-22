class CreateExpsrs < ActiveRecord::Migration[5.2]
  def change
    create_table :expsrs do |t|
      t.integer :cntri_id
      t.string :expo_img
      t.timestamp :created_at
    end
  end
end
