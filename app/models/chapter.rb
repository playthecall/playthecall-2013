class Chapter < ActiveRecord::Base
  has_many   :missions
  belongs_to :game_version

  attr_accessible :name, :game_version_id

  def self.admin_order
    self.order 'game_version_id ASC, created_at DESC'
  end

  def self.current_for(user)
    last_enrollment = user.mission_enrollments.order(:created_at).last
    if last_enrollment
      last_enrollment.mission.chapter
    else
      self.where(game_version_id: user.game_version_id).order(:position).first
    end
  end
end
