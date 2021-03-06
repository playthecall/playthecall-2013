class Mission < ActiveRecord::Base
  has_many   :mission_enrollments

  has_one :badge

  belongs_to :chapter

  validates_inclusion_of :element, in: User::ELEMENTS

  mount_uploader :image, MissionImageUploader

  accepts_nested_attributes_for :badge
  attr_accessible :chapter_id,        :title,    :description,
                  :validation_class,  :image,    :video_url,
                  :validation_params, :position, :element, :slug, :badge_attributes

  def self.first_mission
    Mission.where(:position => 1).first
  end

  def self.for_user(user)
    joins(:chapter).where('chapters.game_version_id = ?', user.game_version_id)
  end

  def validator(enrollment)
    @validator ||= validation_class.constantize.new enrollment
  end

  def next_mission
    chapter.missions.find_by_position(position + 1)
  end

  def self.admin_order
    self.order 'chapter_id ASC, element ASC, position ASC'
  end

  def enroll(user)
    mission_enrollment = MissionEnrollment.new mission: self, user: user
    mission_enrollment.enrollment_images.build
    mission_enrollment
  end

  def to_param
    slug
  end
end
