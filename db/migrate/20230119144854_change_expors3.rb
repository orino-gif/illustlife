class ChangeExpors3 < ActiveRecord::Migration[5.2]
  def change
    add_column :expors, :cont, :string
    add_reference :expors, :path
  end
end
