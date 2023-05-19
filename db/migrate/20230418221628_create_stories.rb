class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.references :ttl, default: 0
      t.integer :ep, default: 0
      t.text :com
    end
  end
end
