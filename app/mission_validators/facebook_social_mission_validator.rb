class FacebookSocialMissionValidator < MissionValidator
  def check
    begin
      enrollment_params[:likes] = link_stats['like_count']
      enrollment.save
    rescue
      Logger.warn 'Facebook check fucked everything!'
      false
    end
  end

  def accomplished?
    likes_enough? && oracle_validated?
  end

  protected
  def link_stats
    Fql.execute(check_query).first
  end

  def check_query
    "SELECT url, normalized_url, share_count, like_count, comment_count, total_count,
    commentsbox_count, comments_fbid, click_count FROM link_stat WHERE url=\"#{enrollment.url}\""
  end

  def likes_enough?
    enrollment_params[:likes] > mission_params[:likes]
  end

  def oracle_validated?
    !mission_params[:oracle] || enrollment_params[:oracle]
  end
end