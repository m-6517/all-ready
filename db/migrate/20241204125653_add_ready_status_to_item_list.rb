class AddReadyStatusToItemList < ActiveRecord::Migration[7.2]
  def change
    add_column :item_lists, :ready_status, :integer, default: 0
  end
end
