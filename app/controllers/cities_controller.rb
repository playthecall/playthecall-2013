class CitiesController < ApplicationController
  def by_country
    @cities = City.where(:country_id => params[:country_id])
    respond_to do |format|
      format.js
    end
  end
end
