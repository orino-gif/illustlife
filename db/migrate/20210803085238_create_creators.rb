class CreateCreators < ActiveRecord::Migration[5.2]
  def change
    create_table :creators, id: false do |t|
      t.column :user_id, 'INTEGER PRIMARY KEY NOT NULL'
      t.string :icon
      t.string :header
      t.string :twitter
      t.string :pixiv
      t.string :sample
      
      t.string :deforume1
      t.string :deforume2
      t.string :deforume3
      
      t.string :background1
      t.string :background2
      t.string :background3
      
      t.string :foreground1
      t.string :foreground2
      t.string :foreground3
      
      t.string :bustup1
      t.string :bustup2
      t.string :bustup3
      
      t.string :rough1
      t.string :rough2
      t.string :rough3
      
      t.string :slide1
      t.string :slide2
      t.string :slide3
      
      t.timestamps
    end
    # 親テーブルに対象が存在しない場合、子テーブルへの保存ができないようにする。
    #add_foreign_key :creators, :users
  end
end
