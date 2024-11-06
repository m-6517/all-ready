class AddSelectedToItemStatuses < ActiveRecord::Migration[7.2]
  def change
    add_column :item_statuses, :selected, :boolean, default: false, null: false
  end
end
