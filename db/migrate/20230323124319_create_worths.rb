class CreateWorths < ActiveRecord::Migration[5.2]
  def change
    create_table :worths, id: false do |t|
      t.column :pst_id, 'INTEGER PRIMARY KEY NOT NULL'
      t.integer :patt, default: 0
      t.integer :cute, default: 0
      t.integer :ero, default: 0
      t.integer :btfl, default: 0
      t.integer :cool, default: 0
      t.integer :funny, default: 0
      t.integer :sympa, default: 0
      t.timestamps
    end
  end
end
