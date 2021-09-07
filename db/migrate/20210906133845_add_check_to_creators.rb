class AddCheckToCreators < ActiveRecord::Migration[5.2]
  def change
    add_column :creators, :deforume_display, :boolean
    add_column :creators, :background_display, :boolean
    add_column :creators, :foreground_display, :boolean
    add_column :creators, :bustup_display, :boolean
    add_column :creators, :rough_display, :boolean
    add_column :creators, :slide_display, :boolean
  end
end
