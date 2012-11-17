# encoding: utf-8

# TODO: Move AWS tokens to somewhere safe
puts "TODO: Move AWS tokens to somewhere safe"

AWS_ACCESS_KEY    = 'AWS_ACCESS_KEY'
AWS_SECRET_KEY    = 'AWS_SECRET_KEY'
AWS_UPLOAD_BUCKET = 'AWS_UPLOAD_BUCKET'

CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage           = :file
    config.enable_processing = false
  else
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     AWS_ACCESS_KEY,
      aws_secret_access_key: AWS_SECRET_KEY,
      region:                'sa-east-1'
    }
    config.fog_directory  = AWS_UPLOAD_BUCKET
  end
end

class CarrierWave::Uploader::Base
  class << self
    def setup_storage
      if Rails.env.test? || Rails.env.development?
        storage :file
      else
        storage :fog
      end
    end
  end
end