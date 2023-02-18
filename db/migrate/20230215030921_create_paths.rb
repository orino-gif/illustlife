class CreatePaths < ActiveRecord::Migration[5.2]
  def change
    create_table :paths do |t|
      t.string :url, default: ''
      t.string :img, default: ''
      t.timestamps
    end
  end
end
