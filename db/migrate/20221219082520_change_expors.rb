class ChangeExpors < ActiveRecord::Migration[5.2]
  def change
    add_column :expors, :kind, :string
    add_column :expors, :hope, :string
    add_column :expors, :fee, :integer
    add_column :expors, :gist, :text
  end
end
