class DefaultItem < ApplicationRecord
  has_many :item_list_default_items, dependent: :destroy
  has_many :item_lists, through: :item_list_default_items
  has_many :item_statuses, dependent: :destroy

  validates :name, presence: true
  validates :position, numericality: { only_integer: true, allow_nil: true }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :selected, inclusion: { in: [ true, false ] }
end
