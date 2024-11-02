class DefaultItem < ApplicationRecord
  has_many :item_list_default_items, dependent: :destroy
  has_many :item_lists, through: :item_list_default_items
  has_many :item_statuses, dependent: :destroy
end
