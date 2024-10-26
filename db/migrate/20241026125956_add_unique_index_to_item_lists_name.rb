class AddUniqueIndexToItemListsName < ActiveRecord::Migration[7.2]
  def change
    add_index :item_lists, :name, unique: true
  end
end
