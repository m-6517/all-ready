class CreateOriginalItems < ActiveRecord::Migration[7.2]
  def change
    create_table :original_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item_list, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
