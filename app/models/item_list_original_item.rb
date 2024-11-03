class ItemListOriginalItem < ApplicationRecord
  belongs_to :original_item
  belongs_to :item_list

  validates :original_item, presence: true
  validates :item_list, presence: true
end
