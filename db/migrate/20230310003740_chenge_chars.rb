class ChengeChars < ActiveRecord::Migration[5.2]
  def change
    add_column :chars, :up_id, :integer
    add_column :chars, :sum, :integer
  end
end
