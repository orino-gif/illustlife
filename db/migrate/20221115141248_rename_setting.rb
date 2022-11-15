class RenameSetting < ActiveRecord::Migration[5.2]
  def change
    rename_column :settings, :recommend, :recom
    rename_column :settings, :minimum, :min
    rename_column :settings, :working, :work_d
    rename_column :settings, :opening, :start
  end
end
