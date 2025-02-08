require 'rails_helper'

RSpec.describe BagContent, type: :model do
  describe 'バリデーション' do
    it 'item_list_idとuser_uuidの組み合わせは一意であること' do
      item_list = create(:item_list)
      user = create(:user)
      create(:bag_content, item_list: item_list, user_uuid: user.uuid)

      duplicate_bag_content = build(:bag_content, item_list: item_list, user_uuid: user.uuid)

      expect(duplicate_bag_content).not_to be_valid
      expect(duplicate_bag_content.errors[:item_list_id]).not_to be_empty
    end
  end

  describe 'アソシエーション' do
    it '持ち物リストに属すること' do
      item_list = create(:item_list)
      bag_content = create(:bag_content, item_list_id: item_list.id)
      expect(bag_content.item_list).to eq(item_list)
    end

    it 'ユーザーに属すること' do
      user = create(:user)
      bag_content = create(:bag_content, user_uuid: user.uuid)
      expect(bag_content.user).to eq(user)
    end

    it '複数のタグを持てること' do
      bag_content = create(:bag_content)
      tag1 = create(:tag, name: "Tag1")
      tag2 = create(:tag, name: "Tag2")
      bag_content.tags << tag1
      bag_content.tags << tag2
      expect(bag_content.tags).to include(tag1, tag2)
    end

    it '複数のブックマークを持てること' do
      bag_content = create(:bag_content)
      bookmark1 = create(:bookmark, bookmarkable: bag_content)
      bookmark2 = create(:bookmark, bookmarkable: bag_content)
      expect(bag_content.bookmarks).to include(bookmark1, bookmark2)
    end
  end
end
