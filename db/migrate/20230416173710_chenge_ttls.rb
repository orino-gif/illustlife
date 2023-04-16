class ChengeTtls < ActiveRecord::Migration[5.2]
  def up
    remove_column :ttls, :com
    remove_column :ttls, :serial
  end
  
  def down
    add_column :ttls, :com, :string
    add_column :ttls, :serial, :string
  end
end
