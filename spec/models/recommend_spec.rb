require 'rails_helper'

RSpec.describe Recommend, type: :model do
  describe 'バリデーション' do
    it '持って行く場所、持って行くものがあれば有効であること' do
      recommend = build(:recommend)
      expect(recommend).to be_valid
    end

    it '持って行く場所、持って行くものは必須項目であること' do
      recommend = build(:recommend, place: nil, item: nil)
      recommend.valid?
      expect(recommend.errors[:place]).to include('を入力してください')
      expect(recommend.errors[:item]).to include('を入力してください')
    end

    it '持って行く場所、持って行くものは255文字以下であること' do
      recommend = build(:recommend, place: 'a' * 256, item: 'b' * 256)
      recommend.valid?
      expect(recommend.errors[:place]).to include('は255文字以内で入力してください')
      expect(recommend.errors[:item]).to include('は255文字以内で入力してください')
    end

    it 'コメントは65535文字以下であること' do
      recommend = build(:recommend, body: 'a' * 65_536)
      recommend.valid?
      expect(recommend.errors[:body]).to include('は65535文字以内で入力してください')
    end
  end

  describe 'アソシエーション' do
    it 'ユーザーに属すること' do
      user = create(:user)
      recommend = create(:recommend, user_uuid: user.uuid)
      expect(recommend.user).to eq(user)
    end

    it '複数のブックマークを持てること' do
      recommend = create(:recommend)
      bookmark1 = create(:bookmark, bookmarkable: recommend)
      bookmark2 = create(:bookmark, bookmarkable: recommend)
      expect(recommend.bookmarks).to include(bookmark1, bookmark2)
    end
  end
end
