class CreateBagContents < ActiveRecord::Migration[7.2]
  def change
    create_table :bag_contents do |t|
      t.references :item_list, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.text :body
      t.timestamps
    end
  end
end
