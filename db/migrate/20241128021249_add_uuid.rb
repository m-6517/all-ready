class AddUuid < ActiveRecord::Migration[7.2]
  def change
    # uuid拡張機能の有効化
    enable_extension 'pgcrypto'

    add_column :users, :uuid, :uuid, default: 'gen_random_uuid()', null: false
    add_column :recommends, :uuid, :uuid, default: 'gen_random_uuid()', null: false
    add_column :bag_contents, :uuid, :uuid, default: 'gen_random_uuid()', null: false

    add_index :users, :uuid, unique: true
    add_index :recommends, :uuid, unique: true
    add_index :bag_contents, :uuid, unique: true

    # 既存データのuuidカラムにデータ追加
    User.reset_column_information
    Recommend.reset_column_information
    BagContent.reset_column_information
    User.find_each { |user| user.update_column(:uuid, SecureRandom.uuid) }
    Recommend.find_each { |recommend| recommend.update_column(:uuid, SecureRandom.uuid) }
    BagContent.find_each { |bag_content| bag_content.update_column(:uuid, SecureRandom.uuid) }
  end
end
