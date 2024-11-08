class AddQuantityToItemStatuses < ActiveRecord::Migration[7.2]
  def change
    add_column :item_statuses, :quantity, :integer, default: 1, null: false
  end
end
