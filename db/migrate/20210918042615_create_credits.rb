class CreateCredits < ActiveRecord::Migration[5.2]
  def change
    create_table :credits, id: false do |t|
      t.column :user_id, 'INTEGER PRIMARY KEY NOT NULL'
      t.string :bank
      t.string :branch_name
      t.string :account_type
      t.integer :account_number
      t.string :account_holder
    
      t.timestamps
    end
  end
end
