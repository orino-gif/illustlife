class AddNsfwRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :is_nsfw, :boolean, default:false
    add_column :requests, :is_anonymous, :boolean, default:false
    add_column :requests, :is_autographed, :boolean, default:false
  end
end
