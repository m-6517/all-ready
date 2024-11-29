class ItemList < ApplicationRecord
  belongs_to :user, primary_key: :uuid, foreign_key: :user_uuid
  has_many :item_list_original_items, dependent: :destroy
  has_many :original_items, through: :item_list_original_items
  has_many :item_list_default_items, dependent: :destroy
  has_many :default_items, through: :item_list_default_items
  has_many :item_statuses, dependent: :destroy
  has_many :bag_contents, dependent: :destroy

  validates :name, presence: true
  validates :user, presence: true

  mount_uploader :cover_image, CoverImageUploader
end
