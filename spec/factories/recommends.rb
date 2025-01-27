FactoryBot.define do
  factory :recommend do
    place { "Default Place" }
    item { "Default Item" }
    body { "Sample body text." }
    user_uuid { create(:user).uuid }
  end
end
