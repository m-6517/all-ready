class Recommend < ApplicationRecord
  validates :place, presence: true, length: { maximum: 255 }
  validates :item, presence: true, length: { maximum: 255 }
  validates :body, length: { maximum: 65_535 }

  belongs_to :user
end
