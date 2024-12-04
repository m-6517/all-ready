class RemovePositionFromDefaultItems < ActiveRecord::Migration[7.2]
  def change
    remove_column :default_items, :position, :integer
  end
end
