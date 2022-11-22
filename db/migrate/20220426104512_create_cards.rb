class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :cus_id, null: false
      t.string :car_id, null: false
      t.timestamps
    end
  end
end
