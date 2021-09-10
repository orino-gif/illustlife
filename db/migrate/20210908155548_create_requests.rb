class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests, id: false do |t|
      t.column :request_id, 'INTEGER PRIMARY KEY NOT NULL',:default=> (1..100000).to_a.sample
      t.integer :request_money
      t.integer :send_id
      t.integer :receive_id
      t.string :status
      t.text :request_message

      t.timestamps
    end
  end
end
