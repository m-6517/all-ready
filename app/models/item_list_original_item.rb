class ItemListOriginalItem < ApplicationRecord
  belongs_to :original_item
  belongs_to :item_list
end
