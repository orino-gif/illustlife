class CreateResms < ActiveRecord::Migration[5.2]
  def change
    create_table :resms do |t|
      t.integer :re_id
      t.integer :noti_id
    end
  end
end
