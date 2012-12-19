class UsersAvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  setup_storage

  process resize_to_fill: [180, 180]
end
