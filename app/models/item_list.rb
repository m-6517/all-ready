class ItemList < ApplicationRecord
  belongs_to :user
  has_many :item_list_original_items, dependent: :destroy
  has_many :original_items, through: :item_list_original_items
  has_many :item_list_default_items, dependent: :destroy
  has_many :default_items, through: :item_list_default_items
  has_many :item_statuses, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :user, presence: true
end
