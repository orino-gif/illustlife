class AddImgTempCreators < ActiveRecord::Migration[5.2]
  def change
    add_column :creators, :temp_img, :string
    add_column :creators, :temp_img2, :string
    add_column :creators, :temp_img3, :string
  end
end
