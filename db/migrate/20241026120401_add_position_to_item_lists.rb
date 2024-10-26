class AddPositionToItemLists < ActiveRecord::Migration[7.2]
  def change
    add_column :item_lists, :position, :integer
  end
end
