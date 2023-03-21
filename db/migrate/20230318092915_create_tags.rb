class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.timestamp :created_at
      t.text :txt
    end
  end
end
