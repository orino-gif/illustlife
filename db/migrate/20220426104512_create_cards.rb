class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards, id: false do |t|
      t.column :user_id, 'INTEGER PRIMARY KEY NOT NULL'
      t.string :cus_id, null: false
      t.string :car_id, null: false
      t.timestamps
    end
  end
end
