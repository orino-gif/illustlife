class CreateCrs < ActiveRecord::Migration[5.2]
  def change
    create_table :crs, id: false do |t|
      t.column :user_id, 'INTEGER PRIMARY KEY NOT NULL'
      t.string :bank
      t.string :branch
      t.string :a_type
      t.integer :number
      t.string :holder
    end
  end
end
