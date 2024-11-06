class RemoveItemListIdFromOriginalItems < ActiveRecord::Migration[7.2]
  def change
    remove_column :original_items, :item_list_id, :integer
  end
end
