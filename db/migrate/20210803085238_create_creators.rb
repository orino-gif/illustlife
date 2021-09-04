class CreateCreators < ActiveRecord::Migration[5.2]
  def change
    create_table :creators, id: false do |t|
      t.column :user_id, 'INTEGER PRIMARY KEY NOT NULL'
      t.string :icon
      t.string :header
      t.string :twitter_url
      t.string :pixiv_url
      
      t.timestamps
    end
    # 親テーブルに対象が存在しない場合、子テーブルへの保存ができないようにする。
    #add_foreign_key :creators, :users
  end
end
