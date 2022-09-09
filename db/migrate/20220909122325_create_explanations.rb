class CreateExplanations < ActiveRecord::Migration[5.2]
  def change
    create_table :explanations do |t|
      t.integer :adviser_id
      t.text :letter_body
      
      t.timestamps
    end
  end
end
