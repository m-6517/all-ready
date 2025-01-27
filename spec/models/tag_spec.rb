require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'タグ名があれば有効であること' do
    tag = build(:tag)
    expect(tag).to be_valid
  end

  it 'タグ名はユニークであること' do
    tag1 = create(:tag)
    tag2 = build(:tag)
    tag2.valid?
    expect(tag2.errors[:name]).to include('はすでに存在します')
  end

  it 'タグ名は必須項目であること' do
    tag = build(:tag, name: nil)
    tag.valid?
    expect(tag.errors[:name]).to include('を入力してください')
  end
end
