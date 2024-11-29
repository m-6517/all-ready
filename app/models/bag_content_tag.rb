class BagContentTag < ApplicationRecord
  belongs_to :bag_content, primary_key: :uuid, foreign_key: :bag_content_uuid
  belongs_to :tag

  validates :tag_id, uniqueness: { scope: :bag_content_uuid }
end
