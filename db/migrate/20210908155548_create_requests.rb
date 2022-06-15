class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :money
      t.string :sender
      t.string :receiver
      t.string :status
      t.text :message
      t.string :file_format
      t.text :sender_icon_url
      t.text :receiver_icon_url
      t.boolean :is_nsfw, default:false
      t.boolean :is_anonymous, default:false
      t.boolean :is_autographed, default:false
      t.datetime :approval_day
      t.integer :delivery_time, default:0
      t.integer :is_in_time_for_the_deadline, default:0
      
      t.string :deliver_img

      t.timestamps
    end
  end
end
