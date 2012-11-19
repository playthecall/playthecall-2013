class FacebookSocialMissionValidator < MissionValidator
  def check
    begin
      update_enrollment_params
    rescue
      Logger.warn 'Facebook check fucked everything!'
      false
    end
  end

  def accomplished?
    likes_enough? && oracle_validated?
  end

  protected
  def update_enrollment_params
    enrollment_params[:fb]    = link_stats.symbolize_keys
    enrollment_params[:likes] = enrollment_params[:fb][:like_count]
    enrollment.save!
  end

  def link_stats
    Fql.execute(check_query).first
  end

  def check_query
    "SELECT url, normalized_url, share_count, like_count, comment_count, total_count, commentsbox_count, comments_fbid, click_count FROM link_stat WHERE url=\"#{enrollment.url}\""
  end

  def likes_enough?
    enrollment_params[:likes] > mission_params[:likes]
  end

  def oracle_validated?
    !mission_params[:oracle] || enrollment_params[:oracle]
  end
end