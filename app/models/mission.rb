class Mission < ActiveRecord::Base
  has_many   :mission_enrollments

  belongs_to :game_version

  validates_inclusion_of :element, in: User::ELEMENTS

  mount_uploader :image, MissionImageUploader

  attr_accessible :game_version_id,   :title,    :description,
                  :validation_class,  :image,    :video_url,
                  :validation_params, :position, :element, :slug

  before_save :compile_description

  def validator(enrollment)
    @validator ||= validation_class.constantize.new enrollment
  end

  def next_mission
    Mission.find_by_element_and_position(element, position + 1)
  end

  def self.version(game_version_id)
    self.where(game_version_id: game_version_id)
  end

  def self.first_for(user)
    self.version(user.game_version_id).
         where(element: user.element, position: 1).limit(1).
         first
  end

  def self.admin_order
    self.order 'game_version_id ASC, element ASC, position ASC'
  end

  protected
  def compile_description
    if description_changed?
      self.html_description = RDiscount.new(description).to_html
    end
  end
end
