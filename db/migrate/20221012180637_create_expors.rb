class CreateExpors < ActiveRecord::Migration[5.2]
  def change
    create_table :expors do |t|
      t.references :user
      t.string :e_img
      t.timestamp :created_at
    end
  end
end
