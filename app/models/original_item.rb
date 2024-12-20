class OriginalItem < ApplicationRecord
  belongs_to :user, foreign_key: :user_uuid
  has_many :item_list_original_items
  has_many :item_lists, through: :item_list_original_items
  has_many :item_statuses, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true
end
