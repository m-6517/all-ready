class AddUuidForeignKey < ActiveRecord::Migration[7.2]
  def change
    # マストアイテムにuser_uuidを追加
    add_column :recommends, :user_uuid, :uuid
    # 持ち物リストにuser_uuidを追加
    add_column :item_lists, :user_uuid, :uuid
    # オリジナルのアイテムにuser_uuidを追加
    add_column :original_items, :user_uuid, :uuid
    # みんなの持ち物にuser_uuidを追加
    add_column :bag_contents, :user_uuid, :uuid
    # タグの中間テーブルにbag_content_uuidを追加
    add_column :bag_content_tags, :bag_content_uuid, :uuid

    # 既存のデータにuuidを設定
    Recommend.reset_column_information
    Recommend.find_each { |auth| auth.update_column(:user_uuid, User.find(auth.user_id).uuid) }
    ItemList.reset_column_information
    ItemList.find_each { |auth| auth.update_column(:user_uuid, User.find(auth.user_id).uuid) }
    OriginalItem.reset_column_information
    OriginalItem.find_each { |auth| auth.update_column(:user_uuid, User.find(auth.user_id).uuid) }
    BagContent.reset_column_information
    BagContent.find_each { |auth| auth.update_column(:user_uuid, User.find(auth.user_id).uuid) }
    BagContentTag.reset_column_information
    BagContentTag.find_each { |bct| bct.update_column(:bag_content_uuid, BagContent.find(bct.bag_content_id).uuid) }

    # null制約を追加
    change_column_null :recommends, :user_uuid, false
    change_column_null :item_lists, :user_uuid, false
    change_column_null :original_items, :user_uuid, false
    change_column_null :bag_contents, :user_uuid, false
    change_column_null :bag_content_tags, :bag_content_uuid, false
  end
end
