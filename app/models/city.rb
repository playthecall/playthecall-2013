class City < ActiveRecord::Base
  attr_accessible :name, :code, :latitude, :longitude, :country_id

  has_one :country
end
