class ItemList < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :user_id }

  belongs_to :user
  has_many :item_list_original_items, dependent: :destroy
  has_many :original_items, through: :item_list_original_items
end
