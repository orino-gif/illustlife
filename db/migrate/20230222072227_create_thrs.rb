class CreateThrs < ActiveRecord::Migration[5.2]
  def change
    create_table :thrs do |t|
      t.string :url, default: ''
      t.string :img, default: ''
      t.timestamps
    end
  end
end
