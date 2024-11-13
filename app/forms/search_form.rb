class SearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :search_term, :string

  def search(bag_contents)
    return bag_contents if search_term.blank?

    search_pattern = "%#{search_term}%"

    bag_contents
      .left_joins(:tags, :item_list)
      .left_joins(item_list: [ :default_items, :original_items ])
      .where(
        'bag_contents.body LIKE :search OR
        tags.name LIKE :search OR
        item_lists.name LIKE :search OR
        default_items.name LIKE :search OR
        original_items.name LIKE :search',
        search: search_pattern
      )
      .distinct
  end
end
