class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :ttl, default: ''
      t.references :exp, default: 0
      t.references :tag, default: 0
      t.boolean :illust, default: true
      t.boolean :minor, default: false
      t.boolean :is_ai, default: false
      t.boolean :org, default: false
      t.boolean :cmt, default: true
      t.integer :up_id, default: 0
      t.timestamps
    end
  end
end
