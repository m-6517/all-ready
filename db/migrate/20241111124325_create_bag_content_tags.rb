class CreateBagContentTags < ActiveRecord::Migration[7.2]
  def change
    create_table :bag_content_tags do |t|
      t.integer :bag_content_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end

    add_foreign_key :bag_content_tags, :bag_contents, column: :bag_content_id
    add_foreign_key :bag_content_tags, :tags, column: :tag_id
    add_index :bag_content_tags, [ :bag_content_id, :tag_id ], unique: true
  end
end
