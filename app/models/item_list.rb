class ItemList < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :user_id }

  belongs_to :user
end
