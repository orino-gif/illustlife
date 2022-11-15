class RenameRequests < ActiveRecord::Migration[5.2]
  def change
    rename_column :requests, :sender_id, :tx_id
    rename_column :requests, :receiver_id, :rx_id
    rename_column :requests, :status, :stts
    rename_column :requests, :format, :fmt
    rename_column :requests, :is_nsfw, :nsfw
    rename_column :requests, :is_anon, :anon
    rename_column :requests, :is_auto, :auto
    rename_column :requests, :message, :msg
  end
end
