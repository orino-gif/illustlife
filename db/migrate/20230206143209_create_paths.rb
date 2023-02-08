class CreatePaths < ActiveRecord::Migration[5.2]
  def change
    create_table :paths do |t|
      t.string :url
      t.string :img
      t.timestamps
    end
  end
end
