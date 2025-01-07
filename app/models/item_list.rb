class ItemList < ApplicationRecord
  belongs_to :user, primary_key: :uuid, foreign_key: :user_uuid
  has_many :item_list_original_items, dependent: :destroy
  has_many :original_items, through: :item_list_original_items
  has_many :item_list_default_items, dependent: :destroy
  has_many :default_items, through: :item_list_default_items
  has_many :item_statuses, -> { order(position: :asc) }, dependent: :destroy
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

  def duplicate
    duplicated_list = ItemList.new
    duplicated_list.name = "#{self.name}のコピー"
    duplicated_list.user_uuid = self.user_uuid
    duplicated_list.ready_status = 0
    duplicated_list.cover_image = nil
    duplicated_list.save!

    self.original_items.each do |original_item|
      duplicated_original_item = original_item.dup
      duplicated_original_item.save!

      item_list_original_item = ItemListOriginalItem.create!(
        item_list: duplicated_list,
        original_item: duplicated_original_item
      )

      original_item_status = ItemStatus.find_by(item_list_id: self.id, original_item_id: original_item.id)

      if original_item_status && original_item_status.selected
        ItemStatus.create!(
          item_list_id: duplicated_list.id,
          original_item_id: duplicated_original_item.id,
          selected: true
        )
      end
    end

    self.default_items.each do |default_item|
      default_item_status = ItemStatus.find_by(item_list_id: self.id, default_item_id: default_item.id)

      if default_item_status
        item_status = ItemStatus.create!(
          item_list_id: duplicated_list.id,
          default_item_id: default_item.id,
          selected: default_item_status.selected
        )
      end
    end

    duplicated_list
  end

  def clear_checked_items
    item_statuses.where(is_checked: true).update_all(is_checked: false)
    update!(ready_status: 0)
  end
end
