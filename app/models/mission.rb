class Mission < ActiveRecord::Base
  has_many   :mission_enrollments

  belongs_to :chapter

  validates_inclusion_of :element, in: User::ELEMENTS

  mount_uploader :image, MissionImageUploader

  attr_accessible :chapter_id,        :title,    :description,
                  :validation_class,  :image,    :video_url,
                  :validation_params, :position, :element, :slug, :oracle

  before_save :compile_description

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
    [self, mission_enrollment]
  end

  def to_param
    slug
  end

  protected
  def compile_description
    if description_changed?
      self.html_description = RDiscount.new(description).to_html
    end
  end
end
