class AddUniqueIndexToPosition < ActiveRecord::Migration[7.2]
  def change
    add_index :item_lists, :position, unique: true
  end
end
