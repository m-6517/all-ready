class Recommend < ApplicationRecord
  belongs_to :user, foreign_key: :user_uuid
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy

  validates :place, presence: true, length: { maximum: 255 }
  validates :item, presence: true, length: { maximum: 255 }
  validates :body, length: { maximum: 65_535 }

  mount_uploader :item_image, ItemImageUploader
  mount_uploader :ogp, OgpUploader

  def image_path
    if self.item_image.present?
      Rails.env.production? ? self.item_image.url : self.item_image.path
    else
      nil
    end
  end
end
