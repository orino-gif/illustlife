class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :money
      t.string :sender
      t.string :receiver
      t.string :status
      t.text :message
      t.string :file_format
      t.string :deliver_img
      t.date :approval_date
      t.date :delivery_date
      t.timestamps
    end
  end
end
