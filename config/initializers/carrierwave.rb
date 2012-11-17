# encoding: utf-8
CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage           = :file
    config.enable_processing = false
  else
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     Settings.s3.access_key,
      aws_secret_access_key: Settings.s3.secret_key
    }
    config.fog_directory  = Settings.s3.upload_bucket
  end
end

class CarrierWave::Uploader::Base
  class << self
    def setup_storage
      if false # Rails.env.test? || Rails.env.development?
        storage :file
      else
        storage :fog
      end
    end
  end
end