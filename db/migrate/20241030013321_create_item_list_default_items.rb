class CreateItemListDefaultItems < ActiveRecord::Migration[7.2]
  def change
    create_table :item_list_default_items do |t|
      t.references :item_list, null: false, foreign_key: true
      t.references :default_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
