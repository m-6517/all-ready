class CreateItemListOriginalItems < ActiveRecord::Migration[7.2]
  def change
    create_table :item_list_original_items do |t|
      t.references :item_list, null: false, foreign_key: true
      t.references :original_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
