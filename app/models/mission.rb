class Mission < ActiveRecord::Base
  belongs_to :game_version

  mount_uploader :image, MissionImageUploader

  attr_accessible :game_version_id,   :title,    :description,
                  :validation_class,  :image,    :video_url,
                  :validation_params, :position, :element

  before_save :compile_description

  def validator(enrollment)
    @validator ||= validation_class.constantize.new enrollment
  end

  def next_mission
    Mission.find_by_element_and_position(element, position + 1)
  end

  def self.first_of_element(element)
    self.find_by_element_and_position element, 1
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
