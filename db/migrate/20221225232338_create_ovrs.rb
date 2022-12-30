class CreateOvrs < ActiveRecord::Migration[5.2]
  def change
    create_table :ovrs do |t|
      t.references :expor
      t.string :o_img #overwritting_image
      t.integer :up_id
      t.timestamps
    end
  end
end
