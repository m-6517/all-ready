class AddPositionAndQuantityToOriginalItems < ActiveRecord::Migration[7.2]
  def change
    add_column :original_items, :position, :integer
    add_column :original_items, :quantity, :integer
  end
end
