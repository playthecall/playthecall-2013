class StatusUpdate < ActiveRecord::Base
  belongs_to :mission_enrollment
  attr_accessible :html_status, :mission_enrollment_id, :status

  validates_presence_of :status

  before_save   :compile_status

  protected
  def compile_status
    if status_changed?
      self.html_status = RDiscount.new(status).to_html
    end
  end
end
