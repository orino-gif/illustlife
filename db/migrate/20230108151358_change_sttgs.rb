class ChangeSttgs < ActiveRecord::Migration[5.2]
  def change
    add_column :sttgs, :job, :string, default: '絵師'
  end
end
