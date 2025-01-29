class OgpUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    if model.is_a?(Recommend)
      "uploads/ogp_images/recommend/#{model.id}"
    else model.is_a?(BagContent)
      "uploads/ogp_images/bag_content/#{model.id}"
    end
  end

  def extension_white_list
    %w[jpg jpeg gif png]
  end
end
