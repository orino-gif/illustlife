class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :money
      t.string :sender
      t.string :receiver
      t.string :status
      t.text :message
      
      t.string :deliver_img

      t.timestamps
    end
  end
end
