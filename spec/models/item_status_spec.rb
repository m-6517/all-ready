require 'rails_helper'

RSpec.describe ItemStatus, type: :model do
  describe 'バリデーション' do
    let(:item_list) { create(:item_list) }
    let(:item_status) { build(:item_status, item_list: item_list) }

    it '有効なItemStatusを作成できること' do
      expect(item_status).to be_valid
    end

    it 'item_listがなければ無効であること' do
      item_status.item_list = nil
      item_status.valid?
      expect(item_status.errors[:item_list]).not_to be_empty
    end

    it 'selectedがtrueまたはfalseでなければ無効であること' do
      item_status.selected = nil
      item_status.valid?
      expect(item_status.errors[:selected]).not_to be_empty
    end

    it 'is_checkedがtrueまたはfalseでなければ無効であること' do
      item_status.is_checked = nil
      item_status.valid?
      expect(item_status.errors[:is_checked]).not_to be_empty
    end

    it 'quantityが1以上の整数でなければ無効であること' do
      item_status.quantity = 0
      item_status.valid?
      expect(item_status.errors[:quantity]).not_to be_empty

      item_status.quantity = 1.5
      item_status.valid?
      expect(item_status.errors[:quantity]).not_to be_empty
    end

    it 'positionが整数またはnilでなければ無効であること' do
      item_status.position = 1.5
      item_status.valid?
      expect(item_status.errors[:position]).not_to be_empty

      item_status.position = nil
      expect(item_status).to be_valid
    end
  end

  describe 'アソシエーション' do
    it '持ち物リストに属すること' do
      item_list = create(:item_list)
      item_status = create(:item_status, item_list: item_list)
      expect(item_status.item_list).to eq(item_list)
    end

    it 'オリジナルアイテムに属すること' do
      original_item = create(:original_item)
      item_status = create(:item_status, original_item: original_item)
      expect(item_status.original_item).to eq(original_item)
    end

    it 'デフォルトアイテムに属すること' do
      default_item = create(:default_item)
      item_status = create(:item_status, default_item: default_item)
      expect(item_status.default_item).to eq(default_item)
    end
  end
end
