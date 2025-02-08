require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it 'アカウント名、メールアドレス、パスワードがあれば有効であること' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'メールアドレスはユニークであること' do
      user1 = create(:user)
      user2 = build(:user)
      user2.email = user1.email
      user2.valid?
      expect(user2.errors[:email]).to include('はすでに存在します')
    end

    it 'アカウント名、メールアドレス、パスワードは必須項目であること' do
      user = build(:user, name: nil, email: nil, password: nil)
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
      expect(user.errors[:email]).to include('を入力してください')
      expect(user.errors[:password]).to include('を入力してください')
    end

    it 'アカウント名は255文字以下であること' do
      user = build(:user, name: 'a' * 256)
      user.valid?
      expect(user.errors[:name]).to include('は255文字以内で入力してください')
    end
  end

  describe 'アソシエーション' do
    it 'providerがgoogle_oauth2の場合、uidは必須項目であること' do
      user = build(:user, provider: "google_oauth2", uid: nil)
      user.valid?
      expect(user.errors[:uid]).to include('を入力してください')
    end

    it 'ユーザーは複数のマストアイテムを持てること' do
      user = create(:user)
      recommend1 = create(:recommend, user_uuid: user.uuid)
      recommend2 = create(:recommend, user_uuid: user.uuid)
      expect(user.recommends).to include(recommend1, recommend2)
    end

    it 'ユーザーは複数の持ち物リストを持てること' do
      user = create(:user)
      item_list1 = create(:item_list, user_uuid: user.uuid)
      item_list2 = create(:item_list, user_uuid: user.uuid)
      expect(user.item_lists).to include(item_list1, item_list2)
    end

    it 'ユーザーは複数のオリジナルアイテムを持てること' do
      user = create(:user)
      original_item1 = create(:original_item, user_uuid: user.uuid)
      original_item2 = create(:original_item, user_uuid: user.uuid)
      expect(user.original_items).to include(original_item1, original_item2)
    end

    it 'ユーザーは複数の持ち物リストを共有できること' do
      user = create(:user)
      bag_content1 = create(:bag_content, user_uuid: user.uuid)
      bag_content2 = create(:bag_content, user_uuid: user.uuid)
      expect(user.bag_contents).to include(bag_content1, bag_content2)
    end

    it 'ユーザーは複数のブックマークを持てること' do
      user = create(:user)
      bookmark1 = create(:bookmark, user_uuid: user.uuid, bookmarkable: create(:recommend))
      bookmark2 = create(:bookmark, user_uuid: user.uuid, bookmarkable: create(:bag_content))
      expect(user.bookmarks).to include(bookmark1, bookmark2)
    end
  end
end
