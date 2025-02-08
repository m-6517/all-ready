require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  it 'ブックマーク可能なオブジェクト、ユーザー情報があれば有効であること' do
    user = create(:user)
    bookmark = build(:bookmark, user_uuid: user.uuid, bookmarkable: create(:recommend))
    expect(bookmark).to be_valid
  end

  it 'ユーザー情報がなければブックマークを作成できないこと' do
    bookmark = build(:bookmark, user_uuid: nil)
    bookmark.valid?
    expect(bookmark.errors[:user_uuid]).not_to be_empty
  end

  it 'ブックマーク可能なオブジェクトが必須であること' do
    bookmark = build(:bookmark, bookmarkable: nil)
    bookmark.valid?
    expect(bookmark.errors[:bookmarkable]).not_to be_empty
  end
end
