class DefaultItem < ApplicationRecord
  has_many :item_list_default_items, dependent: :destroy
  has_many :item_lists, through: :item_list_default_items
  has_many :item_statuses, dependent: :destroy

  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "name" ]
  end
end
