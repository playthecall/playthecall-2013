# It was the night before Christmas and all through the house, not a creature was coding: UTF-8, not even with a mouse.

class FacebookSocialMissionValidatorPresenter < MissionPresenter
  def mission_html
    [
      view.content_tag(
        :div,
        I18n.t('mission.presenter.likes_needed', likes: mission_params[:likes]),
        :class => 'mission-need'),
      #im_ready_button
    ].join.html_safe
  end

  def enrollment_form(form)
    #if mission_params[:oracle]
      #view.link_to check_mission_mission_enrollment_path(mission_enrollment, oracle_token: mission_enrollment[:oracle_token])
    #end
  end

  def enrollment_html
    view.content_tag(:div, nil, class: 'box-social') do
      [
        view.content_tag(:div, nil,
          'class'           => 'fb-like',
          'data-href'       => view.mission_enrollment_url(enrollment.user.nickname, enrollment.mission.slug),
          'data-send'       => true,
          'data-width'      => 450,
          'data-show-faces' => false),
        view.content_tag(:div, nil, class: 'count_likes') do
          [
            view.content_tag(:h4, I18n.t('mission.presenter.like_count',    count: enrollment_params[:likes])),
            view.content_tag(:p,  I18n.t('mission.presenter.missing_likes', count: mission_params[:likes])),
          ].join.html_safe
        end
      ].join.html_safe
    end.html_safe
  end

  protected
  def im_ready_button
    mission_enrollment = view.current_user.mission_enrollments.find_by_mission_id(mission.id)
    unless mission_enrollment.present?
      view.link_to(I18n.t('mission.presenter.im_ready'), view.new_mission_mission_enrollment_path(mission), class: 'btn')
    end
  end
end
