class AddEvaluationRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :evaluation_comment, :text
  end
end
