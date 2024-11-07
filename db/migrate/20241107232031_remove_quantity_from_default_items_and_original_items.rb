class RemoveQuantityFromDefaultItemsAndOriginalItems < ActiveRecord::Migration[7.2]
  def change
    remove_column :default_items, :quantity, :integer, default: 1
    remove_column :original_items, :quantity, :integer, default: 1
  end
end
