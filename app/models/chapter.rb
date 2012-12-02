class Chapter < ActiveRecord::Base
  has_many   :missions
  belongs_to :game_version

  attr_accessible :name, :game_version_id

  def self.admin_order
    self.order 'game_version_id ASC, created_at DESC'
  end
end
