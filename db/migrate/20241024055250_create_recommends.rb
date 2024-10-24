class CreateRecommends < ActiveRecord::Migration[7.2]
  def change
    create_table :recommends do |t|
      t.string :place, null: false
      t.string :item, null: false
      t.text :body
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
