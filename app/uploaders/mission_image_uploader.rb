class MissionImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  setup_storage

  version :medium do
    process resize_to_fit: [680, 354]
  end
end
