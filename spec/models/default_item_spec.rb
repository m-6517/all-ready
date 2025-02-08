require 'rails_helper'

RSpec.describe DefaultItem, type: :model do
  it 'アイテム名があれば有効であること' do
    default_item = build(:default_item)
    expect(default_item).to be_valid
  end

  it 'アイテム名は必須項目であること' do
    default_item = build(:default_item, name: nil)
    default_item.valid?
    expect(default_item.errors[:name]).not_to be_empty
  end
end
