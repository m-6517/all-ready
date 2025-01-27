FactoryBot.define do
  factory :bag_content do
    item_list { create(:item_list) }
    user_uuid { create(:user).uuid }
  end
end
