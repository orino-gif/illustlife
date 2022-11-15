class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :approval_day, :datetime
    remove_column :requests, :delivery_time, :integer
    remove_column :requests, :is_in_time_for_the_deadline, :integer
    remove_column :requests, :deliver_img, :string
    remove_column :requests, :deliver_img2, :string
    remove_column :requests, :deliver_img3, :string
    remove_column :requests, :deliver_img4, :string
    remove_column :requests, :deliver_img5, :string
    remove_column :requests, :deliver_img6, :string
    remove_column :requests, :is_reworked, :boolean
    remove_column :requests, :evaluation_comment, :text
    remove_column :requests, :updated_at, :datetime
    
    rename_column :requests, :file_format, :format
    rename_column :requests, :is_anonymous, :is_anon
    rename_column :requests, :is_autographed, :is_auto

    create_table :works, id: false  do |t|
      t.references :request, foreign_key: true
      t.datetime :del_time
      t.boolean :is_in_time, default:false
      t.boolean :is_rework, default:false
      t.timestamp :updated_at
      t.string :del_img
      t.string :del_img2
      t.string :del_img3
      t.string :del_img4
      t.string :del_img5
      t.string :del_img6
    end
  end
end
