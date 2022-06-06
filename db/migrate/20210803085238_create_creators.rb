class CreateCreators < ActiveRecord::Migration[5.2]
  def change
    create_table :creators, id: false do |t|
      t.column :user_id, 'INTEGER PRIMARY KEY NOT NULL'
      t.string :icon
      t.string :header
      t.string :twitter
      t.string :pixiv
      t.string :instagram
      
      t.integer :recommended_amount, default:3000
      t.integer :working_days, default:14

      t.integer :number_of_request, default:0
      t.integer :number_of_approval, default:0
      t.integer :number_of_works, default:0
      
      t.float :average_delivery_time, default:0
      t.float :deadline_strict_adherence_rate, default:100
      t.float :reply_rate, default:100
      
      t.integer :creator_points, default:0
      t.integer :evaluation_points, default:50
      t.boolean :request_acceptance_permission, default:false
      
      t.timestamps
    end
    # 親テーブルに対象が存在しない場合、子テーブルへの保存ができないようにする。
    #add_foreign_key :creators, :users
  end
end
