class AddEvaluationRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :deliver_img2, :string
    add_column :requests, :deliver_img3, :string
    add_column :requests, :deliver_img4, :string
    add_column :requests, :deliver_img5, :string
    add_column :requests, :deliver_img6, :string

    add_column :requests, :is_reworked, :boolean, default:false
    add_column :requests, :evaluation_comment, :text
  end
end
