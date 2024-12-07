class Bookmark < ApplicationRecord
  belongs_to :user, foreign_key: :user_uuid
  belongs_to :bookmarkable, polymorphic: true

  validates :user_uuid, uniqueness: { scope: [:bookmarkable_id, :bookmarkable_type] }
end
