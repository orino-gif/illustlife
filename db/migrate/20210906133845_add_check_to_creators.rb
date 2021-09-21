class AddCheckToCreators < ActiveRecord::Migration[5.2]
  def change
    add_column :creators, :fg_display, :boolean
    add_column :creators, :bg_display, :boolean
    add_column :creators, :cg_display, :boolean
    change_column_default :creators, :fg_display, from: false, to: true
    change_column_default :creators, :bg_display, from: false, to: true
    change_column_default :creators, :cg_display, from: false, to: true
  end
end
