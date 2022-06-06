class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards, id: false do |t|
      t.integer :user_id, 'INTEGER PRIMARY KEY NOT NULL'
      t.string :customer_id, null: false
      t.string :card_id, null: false

      t.timestamps
    end
  end
end
