class ItemList < ApplicationRecord
  belongs_to :user, primary_key: :uuid, foreign_key: :user_uuid
  has_many :item_list_original_items, dependent: :destroy
  has_many :original_items, through: :item_list_original_items
  has_many :item_list_default_items, dependent: :destroy
  has_many :default_items, through: :item_list_default_items
  has_many :item_statuses, dependent: :destroy
  has_many :bag_contents, dependent: :destroy

  validates :name, presence: true
  validates :user, presence: true
  validates :ready_status, inclusion: { in: 0..100 }

  mount_uploader :cover_image, CoverImageUploader

  def update_ready_status
    total_selected_count = item_statuses.where(selected: true).count
    return self.update!(ready_status: 0) if total_selected_count.zero?
    checked_count = item_statuses.where(selected: true, is_checked: true).count
    ready_status = (checked_count / total_selected_count.to_f * 100).to_i
    self.update!(ready_status: ready_status)
  end
end
