class ItemStatus < ApplicationRecord
  belongs_to :item_list
  belongs_to :original_item, optional: true
  belongs_to :default_item, optional: true
end
