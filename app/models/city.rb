class City < ActiveRecord::Base
  attr_accessible :name, :code, :latitude, :longitude, :country_id

  belongs_to :country
end
