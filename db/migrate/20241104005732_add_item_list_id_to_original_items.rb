class AddItemListIdToOriginalItems < ActiveRecord::Migration[7.2]
  def change
    add_column :original_items, :item_list_id, :integer
    add_foreign_key :original_items, :item_lists
  end
end
