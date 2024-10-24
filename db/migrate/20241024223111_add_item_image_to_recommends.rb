class AddItemImageToRecommends < ActiveRecord::Migration[7.2]
  def change
    add_column :recommends, :item_image, :string
  end
end
