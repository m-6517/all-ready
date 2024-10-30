default_items = DefaultItem.create([
  { name: "スマートフォン", position: 1, quantity: 1, selected: false },
  { name: "鍵", position: 2, quantity: 1, selected: false },
  { name: "財布", position: 3, quantity: 1, selected: false }
])

ItemList.find_each do |item_list|
  default_items.each do |default_item|
    ItemListDefaultItem.create(item_list_id: item_list.id, default_item_id: default_item.id)
  end
end
