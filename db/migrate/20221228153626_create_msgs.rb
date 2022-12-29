class CreateMsgs < ActiveRecord::Migration[5.2]
  def change
    create_table :msgs do |t|
      t.timestamp :created_at
      t.text :s_msg
    end
  end
end
