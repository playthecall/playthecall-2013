class UsersAvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  setup_storage

  process resize_to_fit: [180, 180]
end
