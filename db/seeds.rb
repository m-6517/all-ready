default_items = [
  { name: "スマートフォン", position: 1, quantity: 1, selected: false },
  { name: "鍵", position: 2, quantity: 1, selected: false },
  { name: "財布", position: 3, quantity: 1, selected: false }
].map do |item_data|
  DefaultItem.find_or_create_by(name: item_data[:name]) do |item|
    item.position = item_data[:position]
    item.quantity = item_data[:quantity]
  end
end

ItemList.find_each do |item_list|
  default_items.each do |default_item|
    ItemListDefaultItem.find_or_create_by(item_list_id: item_list.id, default_item_id: default_item.id)

    item_status = ItemStatus.find_or_create_by(item_list_id: item_list.id, default_item_id: default_item.id) do |status|
      status.is_checked = false
      status.selected = false
    end
  end
end
