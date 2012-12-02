class Mission < ActiveRecord::Base
  has_many   :mission_enrollments

  belongs_to :chapter

  validates_inclusion_of :element, in: User::ELEMENTS

  mount_uploader :image, MissionImageUploader

  attr_accessible :chapter_id,        :title,    :description,
                  :validation_class,  :image,    :video_url,
                  :validation_params, :position, :element, :slug

  before_save :compile_description

  def validator(enrollment)
    @validator ||= validation_class.constantize.new enrollment
  end

  def next_mission
    chapter.missions.find_by_position(position + 1)
  end

  def self.chapter(chapter_id)
    self.where(chapter_id: chapter_id)
  end

  def self.first_for(user)
    self.chapter(user.chapter_id).
         where(element: user.element, position: 1).limit(1).
         first
  end

  def self.current_for(user)
    last_enrollment = MissionEnrollment.current_for(user)
    if last_enrollment
      last_enrollment.mission
    else
      nil
    end
  end

  def self.next_for(user)
    current = current_for user
    if current
      self.where(position: current.position + 1, chapter_id: current.chapter_id).first
    else
      Chapter.current_for(user).missions.where(position: 1).first
    end
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

  protected
  def compile_description
    if description_changed?
      self.html_description = RDiscount.new(description).to_html
    end
  end
end
