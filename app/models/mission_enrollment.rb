class MissionEnrollment < ActiveRecord::Base
  belongs_to :mission
  belongs_to :user

  attr_accessible :accomplished, :description, :title, :validation_params

  before_save :compile_description
  before_save :update_accomplished

  def validator
    mission.validator self
  end

  def presenter
    validator.presenter
  end

  protected
  def compile_description
    if description_changed?
      self.html_description = RDiscount.new(description).to_html
    end
    true
  end

  def update_accomplished
    unless accomplished?
      self.accomplished = validator.accomplished?
    end
    true
  end
end
