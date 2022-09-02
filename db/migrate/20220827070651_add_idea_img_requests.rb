class AddIdeaImgRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :request_field, :string
    add_column :requests, :img_size, :string
    add_column :requests, :fix_num, :string
  end
end
