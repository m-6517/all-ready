class RemovePositionFromItemLists < ActiveRecord::Migration[7.2]
  def change
    remove_column :item_lists, :position, :integer
  end
end
