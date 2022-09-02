class AddImgTempCreators < ActiveRecord::Migration[5.2]
  def change
    add_column :creators, :chara_design, :string
    add_column :creators, :chara_design2, :string
    add_column :creators, :chara_design3, :string
  end
end
