class OgpUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    if model.is_a?(Recommend)
      "uploads/ogp_images/recommends/#{model.id}"
    elsif model.is_a?(BagContent)
      "uploads/ogp_images/bag_contents/#{model.id}"
    else
      "uploads/ogp_images/#{model.class.to_s.underscore}/#{model.id}"
    end
  end

  def extension_white_list
    %w[jpg jpeg gif png]
  end

  process :convert_to_webp

  def convert_to_webp
    manipulate! do |img|
      img.format "webp"
      img
    end
  end

  def filename
    super.chomp(File.extname(super)) + ".webp" if original_filename.present?
  end
end
