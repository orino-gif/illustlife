class CreateTemporaries < ActiveRecord::Migration[5.2]
  def change
    create_table :temporaries do |t|
      t.integer :temp_id

      t.timestamps
    end
  end
end
