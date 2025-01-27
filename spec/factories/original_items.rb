FactoryBot.define do
  factory :original_item do
    name { "Default Name" }
    user_uuid { create(:user).uuid }
  end
end
