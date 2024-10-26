require "carrierwave/storage/abstract"
require "carrierwave/storage/file"
require "carrierwave/storage/fog"

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog
    config.fog_provider = "fog/aws"
    config.fog_directory  = Rails.application.credentials.dig(:aws, :bucket_name)
    config.fog_public = false
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id:    Rails.application.credentials.dig(:aws, :access_key_id),
      aws_secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
      region:                Rails.application.credentials.dig(:aws, :region),
      path_style: true
    }
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end
