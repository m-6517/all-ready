class AddPositionToItemStatuses < ActiveRecord::Migration[7.2]
  def change
    add_column :item_statuses, :position, :integer
  end
end
