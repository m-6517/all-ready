class DeleteUserIdAndRecommendIdAndBagContentId < ActiveRecord::Migration[7.2]
  def change
    # user_idとrecommend_idとbag_content_idを削除
    remove_column :recommends, :user_id, :bigint
    remove_column :item_lists, :user_id, :bigint
    remove_column :original_items, :user_id, :bigint
    remove_column :bag_contents, :user_id, :bigint
    remove_column :bag_content_tags, :bag_content_id, :bigint

    # userとrecommendとbag_contentのidを削除
    remove_column :users, :id, :bigint
    remove_column :recommends, :id, :bigint
    remove_column :bag_contents, :id, :bigint
  end
end
