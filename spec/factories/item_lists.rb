FactoryBot.define do
  factory :item_list do
    name { "Default Name" }
    user_uuid { create(:user).uuid }
  end
end
