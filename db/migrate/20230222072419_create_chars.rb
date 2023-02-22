class CreateChars < ActiveRecord::Migration[5.2]
  def change
    create_table :chars do |t|
      t.string :c_name, default: ''
      t.string :cause, default: ''
      t.integer :looks, default: 0
      t.integer :chara, default: 0
      t.integer :ablty, default: 0
      t.integer :str, default: 0
      t.integer :cute, default: 0
      t.integer :ero, default: 0
      t.integer :funny, default: 0
      t.integer :cool, default: 0
      t.references :thr, default: 0
      t.references :ttl, default: 0
      t.timestamps
    end
  end
end
