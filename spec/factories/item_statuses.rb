FactoryBot.define do
  factory :item_status do
    association :item_list
    selected { true }
    is_checked { false }
    quantity { 1 }
    position { 1 }
  end
end
