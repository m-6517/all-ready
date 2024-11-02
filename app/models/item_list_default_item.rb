class ItemListDefaultItem < ApplicationRecord
  belongs_to :default_item
  belongs_to :item_list

  validates :default_item, presence: true
  validates :item_list, presence: true
end
