class CreatePerformances < ActiveRecord::Migration[5.2]
  def change
      create_table :performances, id: false do |t|
      t.column :creator_id, 'INTEGER PRIMARY KEY NOT NULL'
      #アイコンとヘッダー画像の場所の情報
      t.integer :painting, default:0
      t.float :deadline, default:100
      t.float :reply, default:100
      t.integer :points, default:100
      t.integer :evaluation, default:50
      t.integer :earnings, default:0
      t.integer :withdrawal, default:0
    end
  end
end
