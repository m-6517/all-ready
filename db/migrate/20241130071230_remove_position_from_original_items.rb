class RemovePositionFromOriginalItems < ActiveRecord::Migration[7.2]
  def change
    remove_column :original_items, :position, :integer
  end
end
