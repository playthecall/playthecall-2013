class MissionEnrollment < ActiveRecord::Base
  has_many :enrollment_images
  has_many :status_updates

  belongs_to :mission
  belongs_to :user

  validates_presence_of :user_id
  accepts_nested_attributes_for :enrollment_images
                                #reject_if: lambda do |attributes|
                                #  attributes['image'].blank?
                                #end

  attr_accessible :title, :description, :user, :mission, :user_id,
                  :enrollment_images_attributes, :mission_id

  before_create :fill_url
  before_save   :compile_description
  before_save   :update_accomplished

  after_initialize :initialize_validation_params

  scope :accomplished, where(accomplished: true)
  scope :unaccomplished, where(accomplished: false)

  delegate :nickname, to: :user, :prefix => true, :allow_nil => true

  def validator
    mission.validator self
  end

  def presenter(view)
    validator.presenter(view)
  end

  def check(params)
    validator.check params
    user.aggregate_points!
  end

  def async_check(params = {})
    MissionCheckJob.check self, params
  end

  def lazy_check(params = {})
    MissionCheckJob.lazy_check self, params
  end

  def create_next
    if mission.next_mission
      mission.next_mission.mission_enrollments.create user: user
    else
      return nil if mission.element == user.element

      next_mission = Mission.first_for user
      if next_mission && !user.mission_enrollments.from_mission(next_mission.id).exists?
        next_mission.mission_enrollments.create user: user
      else
        nil
      end
    end
  end

  def mission_id=(mission_id)
    self[:mission_id] = mission_id
    initialize_validation_params
    mission_id
  end

  protected

  def accomplished_callback
    MissionMailer.accomplished_mission(self, self.user).deliver
  end

  def fill_url
    self.url = "#{ I18n.t 'url' }m/#{user.nickname}/#{mission.slug}"
  end

  def initialize_validation_params
    if mission
      self.validation_params ||= YAML.dump(validator.initialize_params)
    end
  end

  def compile_description
    if description_changed?
      self.html_description = RDiscount.new(description).to_html
    end
    true
  end

  def update_accomplished
    unless accomplished?
      self.accomplished = validator.accomplished?
      accomplished_callback if accomplished?
    end
    true
  end
end
