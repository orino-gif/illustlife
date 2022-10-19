class CreateExposures < ActiveRecord::Migration[5.2]
  def change
    create_table :exposures do |t|
      t.integer :contributor_id
      t.string :exposed_img

      t.timestamps
    end
  end
end
