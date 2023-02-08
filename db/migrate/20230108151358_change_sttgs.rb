class ChangeSttgs < ActiveRecord::Migration[5.2]
  def change
    add_column :sttgs, :job, :string, default: '評論家'
  end
end
