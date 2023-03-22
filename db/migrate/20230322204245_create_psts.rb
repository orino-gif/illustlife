class CreatePsts < ActiveRecord::Migration[5.2]
  def change
    create_table :psts do |t|
      t.string :ttl, default: ''
      t.references :dtl, default: 0
      t.references :pass, default: 0
      t.references :tag, default: 0
      t.boolean :illust, default: true
      t.boolean :minor, default: false
      t.boolean :is_ai, default: false
      t.boolean :org, default: false
      t.integer :up_id, default: 0
      t.timestamps
    end
  end
end
