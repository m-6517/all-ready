class Tag < ApplicationRecord
  has_many :bag_content_tags, dependent: :destroy
  has_many :bag_contents, through: :bag_content_tags

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["bag_content"]
  end
end
