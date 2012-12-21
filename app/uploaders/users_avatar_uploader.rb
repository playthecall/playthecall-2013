class UsersAvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  setup_storage

  process resize_to_fill: [180, 180]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
