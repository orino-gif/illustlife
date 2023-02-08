class CreateChars < ActiveRecord::Migration[5.2]
  def change
    create_table :chars do |t|
      t.string :c_name
      t.string :genre
      t.string :ttl
      t.integer :looks, default: 0
      t.integer :chara, default: 0
      t.integer :ablity, default: 0
      t.integer :cute, default: 0
      t.integer :ero, default: 0
      t.integer :funny, default: 0
      t.integer :cool, default: 0
      t.timestamps
    end
    add_index :chars, :c_name, unique: true
  end
end
