class CreateExps < ActiveRecord::Migration[5.2]
  def change
    create_table :exps do |t|
      t.timestamp :created_at
      t.text :cnt
    end
  end
end
