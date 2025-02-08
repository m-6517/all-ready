require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'バリデーション' do
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
      expect(tag.errors[:name]).not_to be_empty
    end
  end

  describe 'アソシエーション' do
    it '複数の共有されたリストを持てること' do
      tag = create(:tag)
      bag_content1 = create(:bag_content)
      bag_content2 = create(:bag_content)
      bag_content1.tags << tag
      bag_content2.tags << tag
      expect(tag.bag_contents).to include(bag_content1, bag_content2)
    end
  end
end
