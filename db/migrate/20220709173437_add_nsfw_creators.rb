class AddNsfwCreators < ActiveRecord::Migration[5.2]
  def change
    add_column :creators, :nsfw, :boolean, default:false
  end
end
