require 'rails_helper'

RSpec.describe DefaultItem, type: :model do
  describe 'バリデーション' do
    it 'アイテム名があれば有効であること' do
      default_item = build(:default_item)
      expect(default_item).to be_valid
    end

    it 'アイテム名は必須項目であること' do
      default_item = build(:default_item, name: nil)
      default_item.valid?
      expect(default_item.errors[:name]).not_to be_empty
    end
  end

  describe 'アソシエーション' do
    it '複数の持ち物リストを持てること' do
      default_item = create(:default_item)
      item_list1 = create(:item_list)
      item_list2 = create(:item_list)
      item_list1.default_items << default_item
      item_list2.default_items << default_item
      expect(default_item.item_lists).to include(item_list1, item_list2)
    end

    it '複数のアイテムステータスを持てること' do
      default_item = create(:default_item)
      default_item1 = create(:item_status, default_item: default_item)
      default_item2 = create(:item_status, default_item: default_item)
      expect(default_item.item_statuses).to include(default_item1, default_item2)
    end
  end
end
