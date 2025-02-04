default_items = [
  { name: "スマートフォン" },
  { name: "鍵" },
  { name: "財布" },
  { name: "交通系ICカード" },
  { name: "乗車券" },
  { name: "航空券" },
  { name: "パスポート" },
  { name: "ハンカチ" },
  { name: "ティッシュ" },
  { name: "ウェットティッシュ" },
  { name: "常備薬" },
  { name: "目薬" },
  { name: "マスク" },
  { name: "絆創膏" },
  { name: "折りたたみ傘" },
  { name: "日傘" },
  { name: "エコバッグ" },
  { name: "マイボトル" },
  { name: "時計" },
  { name: "PC" },
  { name: "タブレット" },
  { name: "モバイルバッテリー" },
  { name: "ポケット型Wi-Fi" },
  { name: "充電器" },
  { name: "マウス" },
  { name: "キーボード" },
  { name: "イヤホン" },
  { name: "ヘッドホン" },
  { name: "めがね" },
  { name: "コンタクトレンズ" }

].map do |item_data|
  DefaultItem.find_or_create_by(name: item_data[:name])
end

ItemList.find_each do |item_list|
  default_items.each_with_index do |default_item, index|
    ItemListDefaultItem.find_or_create_by(item_list_id: item_list.id, default_item_id: default_item.id)

    item_status = ItemStatus.find_or_create_by(item_list_id: item_list.id, default_item_id: default_item.id) do |status|
      status.is_checked = false
      status.selected = false
      status.quantity = 1
    end

    if item_status.position.nil?
      item_status.update(position: index + 1)
    end
  end
end
