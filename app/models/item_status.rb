class ItemStatus < ApplicationRecord
  belongs_to :item_list
  belongs_to :original_item, optional: true
  belongs_to :default_item, optional: true

  validates :item_list, presence: true
  validates :is_checked, inclusion: { in: [true, false] }
end
