FactoryBot.define do
  factory :user do
    name { "Test User" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
