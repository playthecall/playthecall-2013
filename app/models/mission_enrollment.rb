class MissionEnrollment < ActiveRecord::Base
  has_many :enrollment_images

  belongs_to :mission
  belongs_to :user

  attr_accessible :title, :description, :user

  before_create :fill_url
  before_save   :compile_description
  before_save   :update_accomplished

  after_initialize :initialize_validation_params

  def validator
    mission.validator self
  end

  def presenter
    validator.presenter
  end

  def check
    validator.check
  end

  def async_check
    MissionCheckJob.check self
  end

  def lazy_check
    MissionCheckJob.lazy_check self
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

  def self.first_for(user)
    Mission.first_for(user).mission_enrollments.create user: user
  end

  def self.from_mission(mission_id)
    self.where(mission_id: mission_id)
  end

  protected
  def accomplished_callback
    'Not done yet, need to create badges'
  end

  def fill_url
    self.url = "m/#{user.nickname}/#{mission.slug}"
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