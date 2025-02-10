class OgpCreator
  require "mini_magick"

  BASE_IMAGE_PATH = "./app/assets/images/ogp_dynamic.png"
  GRAVITY = "northwest"
  TEXT_POSITION_PLACE = "650,150"
  TEXT_POSITION_ITEM = "650,250"
  TEXT_POSITION_USER = "650,350"
  FONT = "./app/assets/fonts/ZenKakuGothicNew-Bold.ttf"
  FONT_SIZE = 35
  USER_FONT_SIZE = 30
  INDENTION_COUNT = 12
  ROW_LIMIT = 8
  DEFAULT_IMAGE_PATH = "./app/assets/images/placeholder.png"

  def self.build(item, place, user_name, recommend: nil, bag_content: nil)
    if !force_update
      return append_timestamp(recommend.ogp.url) if recommend&.ogp.present?
      return append_timestamp(bag_content.ogp.url) if bag_content&.ogp.present?
    end

    if recommend
      place_text = "#{recommend.place}のマストアイテム"
      item_text = prepare_text(recommend.item)
      user_text = prepare_text(recommend.user.name)
      image_path = recommend.image_path.presence || DEFAULT_IMAGE_PATH
    elsif bag_content
      place_text = ""
      item_text = "#{bag_content.item_list.name}の持ち物リスト"
      user_text = prepare_text(bag_content.user.name)
      image_path = bag_content.image_path.presence || DEFAULT_IMAGE_PATH
    else
      place_text = ""
      item_text = ""
      user_text = ""
      image_path = DEFAULT_IMAGE_PATH
    end

    # ベース画像を読み込む
    image = MiniMagick::Image.open(BASE_IMAGE_PATH)

    # 投稿画像をオーバーレイ
    overlay_image = MiniMagick::Image.open(image_path)

    # オーバーレイ画像をリサイズ
    overlay_image.resize "570x570"

    # 画像を合成
    image = image.composite(overlay_image) do |c|
      c.gravity "west"
      c.geometry "+30+0"
    end

    # テキストを合成
    image.combine_options do |config|
      config.font FONT
      config.fill "#1E293B"
      config.gravity GRAVITY
      config.pointsize FONT_SIZE
      config.draw "text #{TEXT_POSITION_PLACE} '#{place_text}'"
    end

    image.combine_options do |config|
      config.font FONT
      config.fill "#1E293B"
      config.gravity GRAVITY
      config.pointsize FONT_SIZE
      config.draw "text #{TEXT_POSITION_ITEM} '#{item_text}'"
    end

    image.combine_options do |config|
      config.font FONT
      config.fill "#1E293B"
      config.gravity GRAVITY
      config.pointsize USER_FONT_SIZE
      config.draw "text #{TEXT_POSITION_USER} '#{user_text}'"
    end

    # 生成した画像をCarrierWaveを通じて保存
    temp_file = Tempfile.create([ "ogp", ".png" ])
    image.write(temp_file.path)

    if recommend
      recommend.ogp = temp_file
      recommend.save!
      temp_file.close
      result = append_timestamp(recommend.ogp.url)
    elsif bag_content
      bag_content.ogp = temp_file
      bag_content.save!
      temp_file.close
      result = append_timestamp(bag_content.ogp.url)
    else
      temp_file.close
      result = append_timestamp(image.path)
    end

    result
  end

  private

  # 画像URLにタイムスタンプを追加
  def self.append_timestamp(url)
    return url if url.blank?
    "#{url}?t=#{Time.current.to_i}"
  end

  # 長いテキストを改行で整形
  def self.prepare_text(text)
    text.to_s.scan(/.{1,#{INDENTION_COUNT}}/)[0...ROW_LIMIT].join("\n")
  end
end
