class ChangeChars < ActiveRecord::Migration[5.2]
  def change
    add_reference :chars, :path
  end
end
