class ItemListDefaultItem < ApplicationRecord
  belongs_to :default_item
  belongs_to :item_list
end
