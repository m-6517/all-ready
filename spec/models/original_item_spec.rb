require 'rails_helper'

RSpec.describe OriginalItem, type: :model do
  describe 'バリデーション' do
    it 'アイテム名、ユーザー情報があれば有効であること' do
      user = create(:user)
      original_item = build(:original_item)
      expect(original_item).to be_valid
    end

    it 'アイテム名は必須項目であること' do
      original_item = build(:original_item, name: nil, user_uuid: nil)
      original_item.valid?
      expect(original_item.errors[:name]).to include('を入力してください')
    end

    it 'ユーザー情報がなければアイテムを作成できないこと' do
      original_item = build(:original_item, user_uuid: nil)
      original_item.valid?
      expect(original_item.errors[:user_uuid]).not_to be_empty
    end
  end

  describe 'アソシエーション' do
    it 'ユーザーに属すること' do
      user = create(:user)
      original_item = create(:original_item, user_uuid: user.uuid)
      expect(original_item.user).to eq(user)
    end

    it '複数の持ち物リストを持てること' do
      original_item = create(:original_item)
      item_list1 = create(:item_list)
      item_list2 = create(:item_list)
      item_list1.original_items << original_item
      item_list2.original_items << original_item
      expect(original_item.item_lists).to include(item_list1, item_list2)
    end

    it '複数のアイテムステータスを持てること' do
      original_item = create(:original_item)
      original_item1 = create(:item_status, original_item: original_item)
      original_item2 = create(:item_status, original_item: original_item)
      expect(original_item.item_statuses).to include(original_item1, original_item2)
    end
  end
end
