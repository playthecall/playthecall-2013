module ApplicationHelper
  def st(*args, &block)
    t(*args, &block).html_safe
  end

  def aside_present?
    @user.present? and not @user.new_record?
  end

  def image_url(path)
    "#{url_options[:host]}/#{image_path path}"
  end

  def presenter_for_mission(mission)
    return @mission_presenter if @mission_presenter

    enrollment = mission.mission_enrollments.build user: current_user
    validator  = mission.validator enrollment

    @mission_presenter = validator.presenter self
  end
end
