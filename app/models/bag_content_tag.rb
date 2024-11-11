class BagContentTag < ApplicationRecord
  belongs_to :bag_content
  belongs_to :tag

  validates :tag_id, uniqueness: { scope: :bag_content_id }
end
