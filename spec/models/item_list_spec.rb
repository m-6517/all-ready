require 'rails_helper'

RSpec.describe ItemList, type: :model do
  it 'リスト名、ユーザー情報があれば有効であること' do
    item_list = build(:item_list)
    expect(item_list).to be_valid
  end

  it 'リスト名は必須項目であること' do
    item_list = build(:item_list, name: nil)
    item_list.valid?
    expect(item_list.errors[:name]).to include('を入力してください')
  end

  it 'ユーザー情報がなければリストを作成できないこと' do
    item_list = build(:item_list, user_uuid: nil)
    item_list.valid?
    expect(item_list.errors[:user_uuid]).to include('は必須です')
  end

  it '準備状況は0以上100以下の数値であること' do
    item_list = build(:item_list, ready_status: 101)
    item_list.valid?
    expect(item_list.errors[:ready_status]).to be_present
  end
end
