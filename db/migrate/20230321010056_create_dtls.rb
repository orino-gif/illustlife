class CreateDtls < ActiveRecord::Migration[5.2]
  def change
    create_table :dtls do |t|
      t.timestamp :created_at
      t.text :cnt
    end
  end
end
