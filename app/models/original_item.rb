class OriginalItem < ApplicationRecord
  belongs_to :user, foreign_key: :user_uuid
  has_many :item_list_original_items
  has_many :item_lists, through: :item_list_original_items
  has_many :item_statuses, dependent: :destroy

  validates :user_uuid, presence: true
  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "name" ]
  end
end
