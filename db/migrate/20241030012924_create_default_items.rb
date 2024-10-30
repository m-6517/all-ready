class CreateDefaultItems < ActiveRecord::Migration[7.2]
  def change
    create_table :default_items do |t|
      t.references :item_list, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :position
      t.integer :quantity, default: 1
      t.boolean :selected, default: false, null: false

      t.timestamps
    end

    
  end
end
