require 'rails_helper'

RSpec.describe BagContent, type: :model do
  it 'item_list_idとuser_uuidの組み合わせは一意であること' do
    item_list = create(:item_list)
    user = create(:user)
    create(:bag_content, item_list: item_list, user_uuid: user.uuid)

    duplicate_bag_content = build(:bag_content, item_list: item_list, user_uuid: user.uuid)

    expect(duplicate_bag_content).not_to be_valid
    expect(duplicate_bag_content.errors[:item_list_id]).to include('はすでに存在します')
  end
end
