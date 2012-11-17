class FacebookSocialMissionValidator < MissionValidator
  def check
    ## TODO: REmember finish it
    # begin
    #   results = link_stats
    #   enrollment_params[:likes] = results['like_count']
    #   enrollment.save
    # rescue
    #   Logger.warn 'Facebook check fucked everything!'
    #   false
    # end
  end

  def accomplished?
    amount_of_likes && oracle_validation
  end

  protected
  def link_stats
    Fql.execute(check_query).first
  end

  def check_query
    "SELECT url, normalized_url, share_count, like_count, comment_count, total_count,
    commentsbox_count, comments_fbid, click_count FROM link_stat WHERE url=\"#{enrollment.url}\""
  end

  def amount_of_likes
    enrollment_params[:likes] > mission_params[:likes]
  end

  def oracle_validation
    !mission_params[:oracle_validation] || enrollment_params[:oracle_validation]
  end
end