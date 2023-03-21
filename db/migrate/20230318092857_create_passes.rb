class CreatePasses < ActiveRecord::Migration[5.2]
  def change
    create_table :passes do |t|
      t.timestamp :created_at
      t.text :way
    end
  end
end
