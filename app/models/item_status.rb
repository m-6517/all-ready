class ItemStatus < ApplicationRecord
  belongs_to :item_list
  belongs_to :original_item, optional: true
  belongs_to :default_item, optional: true

  validates :item_list, presence: true
  validates :selected, inclusion: { in: [ true, false ] }
  validates :is_checked, inclusion: { in: [ true, false ] }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
