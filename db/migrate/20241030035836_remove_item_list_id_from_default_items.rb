class RemoveItemListIdFromDefaultItems < ActiveRecord::Migration[7.2]
  def change
    remove_column :default_items, :item_list_id, :bigint
  end
end
