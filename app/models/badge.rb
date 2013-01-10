class Badge < ActiveRecord::Base
  belongs_to      :mission
  attr_accessible :image, :mission_id, :mission, :message

  mount_uploader :image, BadgeImageUploader
end
