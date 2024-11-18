class BagContent < ApplicationRecord
  belongs_to :item_list
  belongs_to :user
  has_many :bag_content_tags, dependent: :destroy
  has_many :tags, through: :bag_content_tags

  validates :item_list_id, uniqueness: { scope: :user_id }

  def save_with_tags(tag_name:)
    ActiveRecord::Base.transaction do
      self.tags = tag_name.map { |name| Tag.find_or_initialize_by(name: name.strip) }
      save!
    end
    true
  rescue StandardError
    false
  end

  def tag_name
    # NOTE: pluckだと新規作成失敗時に値が残らない(返り値がnilになる)
    tags.map(&:name).join(",")
  end
end

def save_with_tags(tag_name:)
  ActiveRecord::Base.transaction do
    self.tags = tag_name.map { |name| Tag.find_or_initialize_by(name: name.strip) }
    save!
  end
  true
rescue StandardError
  false
end
