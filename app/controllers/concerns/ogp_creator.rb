class OgpCreator
  require "mini_magick"

  BASE_IMAGE_PATH = "./app/assets/images/ogp_dynamic.png"
  GRAVITY = "northwest"
  TEXT_POSITION_PLACE = "700,100"
  TEXT_POSITION_ITEM = "700,200"
  TEXT_POSITION_USER = "700,300"
  FONT = "./app/assets/fonts/ZenKakuGothicNew-Regular.ttf"
  FONT_SIZE = 30
  USER_FONT_SIZE = 25
  INDENTION_COUNT = 16
  ROW_LIMIT = 8
  DEFAULT_IMAGE_PATH = "./app/assets/images/placeholder.png"

  def self.build(item, place, user_name, recommend: nil, bag_content: nil)
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

    # 最終的な画像を返す
    image
  end

  private

  # アップロードされた画像のパスを取得（存在しない場合はデフォルト画像を使用）
  def self.uploaded_image_path(base_path:, image_url:)
    if image_url.present?
      Rails.root.join("public", "uploads", base_path, image_url).to_s
    else
      DEFAULT_IMAGE_PATH
    end
  end

  # 長いテキストを改行で整形
  def self.prepare_text(text)
    text.to_s.scan(/.{1,#{INDENTION_COUNT}}/)[0...ROW_LIMIT].join("\n")
  end

  def self.upload_to_s3(image)
    # S3リソースの初期化
    s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
  
    # S3のバケットを取得
    bucket = s3.bucket(ENV['AWS_BUCKET_NAME'])
  
    # 一時ファイルを作成
    tempfile = Tempfile.new(['ogp_dynamic', '.png'])
    image.write(tempfile.path)
  
    # S3にアップロードする際のオブジェクト名を設定
    object = bucket.object("ogp_dynamic.png")
  
    # アップロード
    object.upload_file(tempfile.path, acl: 'public-read')
  
    # アップロードされたオブジェクトのURLを取得
    object.public_url
  end
end
