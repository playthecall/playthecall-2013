class UsersAvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  setup_storage

  version :thumb do
    process resize_to_fit: [40, 40]
  end

  version :medium do
    process resize_to_fit: [180, 180]
  end
end