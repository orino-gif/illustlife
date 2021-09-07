class RenameDeforume1ColumnToCreators < ActiveRecord::Migration[5.2]
  def change
    change_column_default :creators, :deforume_display, from: false, to: true
    change_column_default :creators, :background_display, from: false, to: true
    change_column_default :creators, :foreground_display, from: false, to: true
    change_column_default :creators, :bustup_display, from: false, to: true
    change_column_default :creators, :rough_display, from: false, to: true
    change_column_default :creators, :slide_display, from: false, to: true
  end
end
