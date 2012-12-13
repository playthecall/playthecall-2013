# It was the night before Christmas and all through the house, not a creature was coding: UTF-8, not even with a mouse.

class FacebookSocialMissionValidatorPresenter < MissionPresenter
  def mission_html
    [
      view.content_tag(
        :div,
        I18n.t('mission.presenter.likes_needed', likes: mission_params[:likes]),
        :class => 'mission-need'),
      view.link_to(I18n.t('mission.presenter.im_ready'), view.new_mission_mission_enrollment_path(mission), class: 'btn')
    ].join.html_safe
  end

  def enrollment_html
    "Not done Yet!".html_safe
  end
end