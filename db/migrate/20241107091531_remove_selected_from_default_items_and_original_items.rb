class RemoveSelectedFromDefaultItemsAndOriginalItems < ActiveRecord::Migration[7.2]
  def change
    remove_column :default_items, :selected, :boolean, default: false, null: false
    remove_column :original_items, :selected, :boolean, default: false, null: false
  end
end
