class Recommend < ApplicationRecord
  validates :place, presence: true, length: { maximum: 255 }
  validates :item, presence: true, length: { maximum: 255 }
  validates :body, length: { maximum: 65_535 }

  belongs_to :user, foreign_key: :user_uuid
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy

  mount_uploader :item_image, ItemImageUploader
  mount_uploader :ogp, OgpUploader

  def image_path
    if self.item_image.present?
      self.item_image.url
    else
      nil
    end
  end
end
