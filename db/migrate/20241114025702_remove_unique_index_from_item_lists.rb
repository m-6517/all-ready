class RemoveUniqueIndexFromItemLists < ActiveRecord::Migration[7.2]
  def change
    remove_index :item_lists, :name
    remove_index :item_lists, [:user_id, :name] if index_exists?(:item_lists, [:user_id, :name])
  end
end
