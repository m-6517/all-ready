class Recommend < ApplicationRecord
  validates :place, presence: true, length: { maximum: 255 }
  validates :item, presence: true, length: { maximum: 255 }
  validates :body, length: { maximum: 65_535 }

  belongs_to :user, foreign_key: :user_uuid
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy

  mount_uploader :item_image, ItemImageUploader

  def image_path
    if self.item_image.present?
      Rails.root.join("public/uploads/recommend/item_image", self.uuid, self.item_image.file.file).to_s
    else
      nil
    end
  end
end
