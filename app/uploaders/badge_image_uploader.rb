class BadgeImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  setup_storage

  version :small do
    process resize_to_fit: [45, 45]
  end

  version :medium do
    process resize_to_fit: [135, 135]
  end
end
