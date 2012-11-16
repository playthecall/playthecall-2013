class Mission < ActiveRecord::Base
  belongs_to :game_version

  attr_accessible :description, :image, :title, :validation_class, :validation_params, :video_url

  before_save :compile_description

  def validator(enrollment)
    @validator ||= validation_class.constantize.new enrollment
  end

  protected
  def compile_description
    if description_changed?
      self.html_description = RDiscount.new(description).to_html
    end
  end
end
