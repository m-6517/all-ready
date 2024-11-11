class BagContent < ApplicationRecord
  belongs_to :item_list
  belongs_to :user

  validates :item_list_id, uniqueness: { scope: :user_id }
end
