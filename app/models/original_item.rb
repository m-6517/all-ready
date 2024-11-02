class OriginalItem < ApplicationRecord
  belongs_to :user
  has_many :item_list_original_items, dependent: :destroy
  has_many :item_lists, through: :item_list_original_items
  has_many :item_statuses, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true
  validates :item_list_id, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :position, numericality: { only_integer: true, allow_nil: true }
end
