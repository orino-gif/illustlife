class CreateCreators < ActiveRecord::Migration[5.2]
  def change
    create_table :creators do |t|
      t.string :name
      t.string :image1
      t.string :image2

      t.timestamps
    end
  end
end
