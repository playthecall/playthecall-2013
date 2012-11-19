class GameVersion < ActiveRecord::Base
  attr_accessible :language, :name
  has_many :missions
end
