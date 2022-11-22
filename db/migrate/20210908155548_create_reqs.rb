class CreateReqs < ActiveRecord::Migration[5.2]
  def change
    create_table :reqs do |t|
      t.integer :money
      t.integer :tx_id
      t.integer :rx_id
      t.string :stts
      t.string :fmt
      t.boolean :nsfw, default:false
      t.boolean :anon, default:false
      t.boolean :auto, default:false
      t.text :msg
      t.timestamp :created_at
    end
    
    create_table :works, id: false do |t|
      t.column :req_id, 'INTEGER PRIMARY KEY NOT NULL'
      t.datetime :d_time
      t.datetime :in_time
      t.boolean :rework, default:false
      t.timestamp :updated_at
      t.string :images
    end
  end
end
