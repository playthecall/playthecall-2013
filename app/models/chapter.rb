class Chapter < ActiveRecord::Base
  has_many   :missions
  belongs_to :game_version

  attr_accessible :name, :game_version_id, :position

  def self.finished?(chapter, user)
    accomplished_missions_quantity = user.mission_enrollments.
      where(accomplished: true, mission_id: chapter.missions.map(&:id)).count
    accomplished_missions_quantity == chapter.missions.count
  end

  def self.admin_order
    self.order 'game_version_id ASC, created_at DESC'
  end
end
