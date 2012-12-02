class GameVersion < ActiveRecord::Base
  has_many :chapters

  attr_accessible :language, :name
end
