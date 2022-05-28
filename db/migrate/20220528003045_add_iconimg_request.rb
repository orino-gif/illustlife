class AddIconimgRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :sender_icon_url, :text
    add_column :requests, :receiver_icon_url, :text
  end
end
