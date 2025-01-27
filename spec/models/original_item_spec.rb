require 'rails_helper'

RSpec.describe OriginalItem, type: :model do
  it 'アイテム名、ユーザー情報があれば有効であること' do
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
