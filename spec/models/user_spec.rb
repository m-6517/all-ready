require 'rails_helper'

RSpec.describe User, type: :model do
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

  it 'アカウント名名は255文字以下であること' do
    user = build(:user, name: 'a' * 256)
    user.valid?
    expect(user.errors[:name]).to include('は255文字以内で入力してください')
  end
end
