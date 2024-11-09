class AddCoverImageToItemLists < ActiveRecord::Migration[7.2]
  def change
    add_column :item_lists, :cover_image, :string
  end
end
