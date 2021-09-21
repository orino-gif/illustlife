class CreateCreators < ActiveRecord::Migration[5.2]
  def change
    create_table :creators, id: false do |t|
      t.column :user_id, 'INTEGER PRIMARY KEY NOT NULL'
      t.string :icon
      t.string :header
      t.string :twitter
      t.string :pixiv
      t.string :fg1
      t.string :fg2
      t.string :fg3
      t.string :bg1
      t.string :bg2
      t.string :bg3
      t.string :cg1
      t.string :cg2
      t.string :cg3
      
      t.timestamps
    end
    # 親テーブルに対象が存在しない場合、子テーブルへの保存ができないようにする。
    #add_foreign_key :creators, :users
  end
end
