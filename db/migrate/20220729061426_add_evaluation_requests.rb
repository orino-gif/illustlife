class AddEvaluationRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :is_reworked, :boolean, default:false
    add_column :requests, :evaluation_comment, :text
  end
end
