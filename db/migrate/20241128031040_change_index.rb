class ChangeIndex < ActiveRecord::Migration[7.2]
  def change
    # 既存のindexを削除
    remove_index :recommends, name: "index_recommends_on_user_id"
    remove_index :item_lists, name: "index_item_lists_on_user_id"
    remove_index :original_items, name: "index_original_items_on_user_id"
    remove_index :bag_contents, name: "index_bag_contents_on_user_id"
    remove_index :bag_content_tags, name: "index_bag_content_tags_on_bag_content_id_and_tag_id"

    # uuidをindexとして追加
    add_index :recommends, :user_uuid
    add_index :item_lists, :user_uuid
    add_index :original_items, :user_uuid
    add_index :bag_contents, :user_uuid
    add_index :bag_content_tags, :bag_content_uuid
  end
end
