class AddCaptionUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_deleted, :boolean, default: false
    add_column :users, :caption, :string

  end
end
