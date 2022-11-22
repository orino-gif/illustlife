class CreateCres < ActiveRecord::Migration[5.2]
  def change
    create_table :cres, id: false do |t|
      t.column :user_id, 'INTEGER PRIMARY KEY NOT NULL'
      t.string :icon
      t.string :hdr
      t.string :twtr
      t.string :pixiv
      t.string :insta
      t.string :yt
      t.string :link
    end
    
    create_table :sttgs, id: false do |t|
      t.column :cre_id, 'INTEGER PRIMARY KEY NOT NULL'
      t.integer :recom, default:5000
      t.integer :min, default:1000
      t.integer :work_d, default:14
      t.boolean :start, default:false
      t.boolean :nsfw, default:false
    end
    
    create_table :pfms, id: false do |t|
      t.column :cre_id, 'INTEGER PRIMARY KEY NOT NULL'
      t.integer :pic, default:0
      t.integer :dl, default:100
      t.integer :reply, default:100
      t.integer :point, default:100
      t.integer :eval, default:50
      t.integer :sales, default:0
      t.integer :wdl, default:0
    end
  end
end
