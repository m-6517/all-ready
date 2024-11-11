class Tag < ApplicationRecord
  has_many :bag_content_tags, dependent: :destroy
  has_many :bag_contents, through: :bag_content_tags

  validates :name, presence: true, uniqueness: true
end
