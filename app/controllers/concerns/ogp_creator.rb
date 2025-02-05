class OgpCreator
  require "mini_magick"

  BASE_IMAGE_PATH = "./app/assets/images/ogp_dynamic.png"
  GRAVITY = "northwest"
  TEXT_POSITION_PLACE = "650,150"
  TEXT_POSITION_ITEM = "650,250"
  TEXT_POSITION_USER = "650,350"
  FONT = "./app/assets/fonts/ZenKakuGothicNew-Bold.ttf"
  FONT_SIZE = 35
  USER_FONT_SIZE = 25
  INDENTION_COUNT = 12
  ROW_LIMIT = 8
  DEFAULT_IMAGE_PATH = "./app/assets/images/placeholder.png"

  def self.build(item, place, user_name, recommend: nil, bag_content: nil)
    # 既存のOGP画像がある場合はそれを返す
    return recommend.ogp.url if recommend&.ogp.present?
    return bag_content.ogp.url if bag_content&.ogp.present?

    if recommend
      place_text = "#{recommend.place}のマストアイテム"
      item_text = prepare_text(recommend.item)
      user_text = prepare_text(recommend.user.name)
      image_path = recommend.image_path
    elsif bag_content
      place_text = ""
      item_text = "#{bag_content.item_list.name}の持ち物リスト"
      user_text = prepare_text(bag_content.user.name)
      image_path = bag_content.image_path
    else
      place_text = ""
      item_text = ""
      user_text = ""
      image_path = DEFAULT_IMAGE_PATH
    end

    image_path ||= DEFAULT_IMAGE_PATH

    # ベース画像を読み込む
    begin
      image = MiniMagick::Image.open(BASE_IMAGE_PATH)
    rescue MiniMagick::Error => e
      Rails.logger.error "Failed to open base image: #{e.message}"
      Rails.logger.debug "Base image path: #{BASE_IMAGE_PATH}"
      raise "Base image not found"
    rescue StandardError => e
      Rails.logger.error "Unexpected error occurred while opening base image: #{e.message}"
      Rails.logger.debug "Base image path: #{BASE_IMAGE_PATH}"
      raise "Failed to open base image"
    end

    # 投稿画像をオーバーレイ
    begin
      overlay_image = MiniMagick::Image.open(image_path)
    rescue MiniMagick::Error => e
      Rails.logger.error "Failed to open overlay image: #{e.message}"
      Rails.logger.debug "Overlay image path: #{image_path}"
      raise "Overlay image not found"
    rescue StandardError => e
      Rails.logger.error "Unexpected error occurred while opening overlay image: #{e.message}"
      Rails.logger.debug "Overlay image path: #{image_path}"
      raise "Failed to open overlay image"
    end

    # オーバーレイ画像をリサイズ
    begin
      overlay_image.resize "570x570"
    rescue MiniMagick::Error => e
      Rails.logger.error "Failed to resize overlay image: #{e.message}"
      Rails.logger.debug "Overlay image path: #{image_path}"
      raise "Failed to resize overlay image"
    rescue StandardError => e
      Rails.logger.error "Unexpected error occurred while resizing overlay image: #{e.message}"
      Rails.logger.debug "Overlay image path: #{image_path}"
      raise "Failed to resize overlay image"
    end

    # 画像を合成
    begin
      image = image.composite(overlay_image) do |c|
        c.gravity "west"
        c.geometry "+30+0"
      end
    rescue MiniMagick::Error => e
      Rails.logger.error "Failed to composite images: #{e.message}"
      Rails.logger.debug "Base image path: #{BASE_IMAGE_PATH}, Overlay image path: #{image_path}"
      raise "Failed to composite images"
    rescue StandardError => e
      Rails.logger.error "Unexpected error occurred while compositing images: #{e.message}"
      Rails.logger.debug "Base image path: #{BASE_IMAGE_PATH}, Overlay image path: #{image_path}"
      raise "Failed to composite images"
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
    temp_file = Tempfile.new("ogp", ".png")
    image.write(temp_file.path)

    if recommend
      recommend.ogp = temp_file
      recommend.save!
      temp_file.close
      recommend.ogp.url
    elsif bag_content
      bag_content.ogp = temp_file
      bag_content.save!
      temp_file.close
      bag_content.ogp.url
    else
      temp_file.close
      image.path
    end
  end

  private

  # 長いテキストを改行で整形
  def self.prepare_text(text)
    text.to_s.scan(/.{1,#{INDENTION_COUNT}}/)[0...ROW_LIMIT].join("\n")
  end
end
