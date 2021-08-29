class CreateCreators < ActiveRecord::Migration[5.2]
  def change
    create_table :creators do |t|
      t.string :icon
      t.string :header
      t.references :user
      
      t.timestamps
    end
    # 親テーブルに対象が存在しない場合、子テーブルへの保存ができないようにする。
    add_foreign_key :creators, :users
  end
end
