class FacebookSocialMissionValidator < MissionValidator
  def accomplished?
    amount_of_likes && oracle_validation
  end

  protected
  def amount_of_likes
    enrollment_params[:likes] > mission_params[:likes]
  end

  def oracle_validation
    !mission_params[:oracle_validation] || enrollment_params[:oracle_validation]
  end
end