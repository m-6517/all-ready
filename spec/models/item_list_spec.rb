require 'rails_helper'

RSpec.describe ItemList, type: :model do
  describe 'バリデーション' do
    it 'リスト名、ユーザー情報があれば有効であること' do
      user = create(:user)
      item_list = build(:item_list)
      expect(item_list).to be_valid
    end

    it 'リスト名は必須項目であること' do
      item_list = build(:item_list, name: nil)
      item_list.valid?
      expect(item_list.errors[:name]).not_to be_empty
    end

    it 'ユーザー情報がなければリストを作成できないこと' do
      item_list = build(:item_list, user_uuid: nil)
      item_list.valid?
      expect(item_list.errors[:user_uuid]).not_to be_empty
    end

    it '準備状況は0以上100以下の数値であること' do
      item_list = build(:item_list, ready_status: 101)
      item_list.valid?
      expect(item_list.errors[:ready_status]).to be_present
    end
  end

  describe 'アソシエーション' do
    it 'ユーザーに属すること' do
      user = create(:user)
      item_list = create(:item_list, user_uuid: user.uuid)
      expect(item_list.user).to eq(user)
    end

    it '複数のデフォルトアイテムを持てること' do
      user = create(:user)
      item_list = create(:item_list, user_uuid: user.uuid)
      default_item1 = create(:default_item)
      default_item2 = create(:default_item)
      item_list.default_items << default_item1
      item_list.default_items << default_item2
      expect(item_list.default_items).to include(default_item1, default_item2)
    end

    it '複数のオリジナルアイテムを持てること' do
      user = create(:user)
      item_list = create(:item_list, user_uuid: user.uuid)
      original_item1 = create(:original_item, user_uuid: user.uuid)
      original_item2 = create(:original_item, user_uuid: user.uuid)
      item_list.original_items << original_item1
      item_list.original_items << original_item2
      expect(item_list.original_items).to include(original_item1, original_item2)
    end

    it '複数のアイテムステータスを持てること' do
      item_list = create(:item_list)
      item_status1 = create(:item_status, item_list: item_list)
      item_status2 = create(:item_status, item_list: item_list)
      expect(item_list.item_statuses).to include(item_status1, item_status2)
    end

    it '複数の共有されたリストを持てること' do
      item_list = create(:item_list)
      bag_content1 = create(:bag_content, item_list: item_list)
      bag_content2 = create(:bag_content, item_list: item_list)
      expect(item_list.bag_contents).to include(bag_content1, bag_content2)
    end
  end
end
