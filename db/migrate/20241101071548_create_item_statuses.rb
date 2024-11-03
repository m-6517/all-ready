class CreateItemStatuses < ActiveRecord::Migration[7.2]
  def change
    create_table :item_statuses do |t|
      t.references :item_list, null: false
      t.references :original_item
      t.references :default_item
      t.boolean :is_checked, default: false, null: false

      t.timestamps
    end

    add_foreign_key :item_statuses, :item_lists
    add_foreign_key :item_statuses, :original_items
    add_foreign_key :item_statuses, :default_items
  end
end
