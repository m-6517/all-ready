require 'rails_helper'

RSpec.describe Recommend, type: :model do
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
