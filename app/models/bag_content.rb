class BagContent < ApplicationRecord
  belongs_to :item_list
  belongs_to :user, foreign_key: :user_uuid
  has_many :bag_content_tags, primary_key: :uuid, foreign_key: :bag_content_uuid, dependent: :destroy
  has_many :tags, through: :bag_content_tags
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy

  validates :item_list_id, uniqueness: { scope: :user_uuid }

  def self.ransackable_attributes(auth_object = nil)
    ["body"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["item_list", "tags"]
  end

  mount_uploader :ogp, OgpUploader

  def image_path
    if self.item_list.present? && self.item_list.cover_image.present?
      Rails.env.production? ? self.item_list.cover_image.url : self.item_list.cover_image.path
    else
      nil
    end
  end
end
