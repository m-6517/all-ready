require 'rails_helper'

RSpec.describe ItemStatus, type: :model do
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
