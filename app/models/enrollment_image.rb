class EnrollmentImage < ActiveRecord::Base
  belongs_to      :mission_enrollment
  attr_accessible :image

  mount_uploader :image, MissionImageUploader
end
