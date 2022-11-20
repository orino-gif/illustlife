class RenameExplanations < ActiveRecord::Migration[5.2]
  def change
    rename_column :explanations, :adviser_id, :adv_id
    rename_column :explanations, :letter_body, :a_msg
  end
end
