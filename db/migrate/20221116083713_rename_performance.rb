class RenamePerformance < ActiveRecord::Migration[5.2]
  def change
    rename_column :performances, :painting, :pic
    rename_column :performances, :deadline, :dl
    rename_column :performances, :points, :point
    rename_column :performances, :evaluation, :eval
    rename_column :performances, :earnings, :sales
    rename_column :performances, :withdrawal, :wdl
  end
end
