FactoryBot.define do
  factory :bookmark do
    user_uuid { create(:user).uuid }

    trait :with_recommend do
      association :bookmarkable, factory: :recommend
    end

    trait :with_bag_content do
      association :bookmarkable, factory: :bag_content
    end
  end
end
