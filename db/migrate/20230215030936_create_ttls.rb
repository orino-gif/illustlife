class CreateTtls < ActiveRecord::Migration[5.2]
  def change
    create_table :ttls do |t|
    t.string :t_name, default: ''
    t.string :genre, default: ''
    t.string :pub, default: ''
    t.boolean :com, default: true
    t.boolean :serial, default: true
    t.string :auth, default: ''
    t.references :path, default: 0
    t.timestamp :created_at
    end
  end
end
