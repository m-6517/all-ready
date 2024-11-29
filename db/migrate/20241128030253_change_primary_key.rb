class ChangePrimaryKey < ActiveRecord::Migration[7.2]
  def change
    # 既存の外部キー制約を解除
    remove_foreign_key :recommends, :users
    remove_foreign_key :item_lists, :users
    remove_foreign_key :original_items, :users
    remove_foreign_key :bag_contents, :users
    remove_foreign_key :bag_content_tags, :bag_contents

    # 主キーをuuidに変更
    execute 'ALTER TABLE users DROP CONSTRAINT users_pkey;'
    execute 'ALTER TABLE users ADD PRIMARY KEY (uuid);'
    execute 'ALTER TABLE recommends DROP CONSTRAINT recommends_pkey;'
    execute 'ALTER TABLE recommends ADD PRIMARY KEY (uuid);'
    execute 'ALTER TABLE bag_contents DROP CONSTRAINT bag_contents_pkey;'
    execute 'ALTER TABLE bag_contents ADD PRIMARY KEY (uuid);'

    # 外部キー制約を再設定
    add_foreign_key :recommends, :users, column: :user_uuid, primary_key: :uuid
    add_foreign_key :item_lists, :users, column: :user_uuid, primary_key: :uuid
    add_foreign_key :original_items, :users, column: :user_uuid, primary_key: :uuid
    add_foreign_key :bag_contents, :users, column: :user_uuid, primary_key: :uuid
    add_foreign_key :bag_content_tags, :bag_contents, column: :bag_content_uuid, primary_key: :uuid
  end
end
