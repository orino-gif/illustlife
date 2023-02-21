class ChangeSttgs < ActiveRecord::Migration[5.2]
  def change
    add_column :sttgs, :job, :string, default: '一般'
  end
end
