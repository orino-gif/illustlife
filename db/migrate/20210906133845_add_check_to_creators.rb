class AddCheckToCreators < ActiveRecord::Migration[5.2]
  def change
    add_column :creators, :deforume_display, :boolean
    add_column :creators, :background_display, :boolean
    add_column :creators, :foreground_display, :boolean
    change_column_default :creators, :deforume_display, from: false, to: true
    change_column_default :creators, :background_display, from: false, to: true
    change_column_default :creators, :foreground_display, from: false, to: true
  end
end
