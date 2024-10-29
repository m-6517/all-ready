class OriginalItem < ApplicationRecord
  belongs_to :user
  has_many :item_list_original_items, dependent: :destroy
  has_many :item_lists, through: :item_list_original_items
end
