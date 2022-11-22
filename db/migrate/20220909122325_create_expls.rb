class CreateExpls < ActiveRecord::Migration[5.2]
  def change
    create_table :expls do |t|
      t.integer :adv_id
      t.text :a_msg
      t.timestamp :created_at
    end
  end
end