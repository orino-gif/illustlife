class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    remove_column :creators, :recommend, :integer
    remove_column :creators, :minimum, :integer
    remove_column :creators, :working, :integer
    remove_column :creators, :opening, :boolean
    remove_column :creators, :nsfw, :boolean
    
    create_table :settings, id: false do |t|
      t.column :creator_id, 'INTEGER PRIMARY KEY NOT NULL'
      t.integer :recommend, default:5000
      t.integer :minimum, default:1000
      t.integer :working, default:14
      t.boolean :opening, default:false
      t.boolean :nsfw, default:false
    end
  end
end
