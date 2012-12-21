module ApplicationHelper
  def st(*args, &block)
    t(*args, &block).html_safe
  end

  def image_url(path)
    "#{url_options[:host]}/#{image_path path}"
  end

  def avatar_url(user=current_user)
    placeholder = "avatar-placeholder.jpg"
    user.avatar? ? user.avatar : placeholder
  end

  def presenter_for_mission(mission)
    return @mission_presenter.mission_html if @mission_presenter

    enrollment = mission.mission_enrollments.build user: current_user
    validator  = mission.validator enrollment

    @mission_presenter = validator.presenter(self)
    @mission_presenter.mission_html
  end

  def presenter_for_enrollment_form(enrollment, form)
    enrollment.presenter(self).enrollment_form form
  end

  def presenter_for_enrollment(enrollment)
    enrollment.presenter(self).enrollment_html
  end

  def user_current_mission
    mission_enrollment = current_user.current_mission_enrollment
    if mission_enrollment.present?
      mission_enrollment_path(current_user.nickname, mission_enrollment.mission.slug)
    else
      mission_path(current_user.current_mission)
    end
  end

  def badge_for_user(user)
    user.mission_enrollments.accomplished.map do |me|
      me.mission.badge
    end.compact
  end

  def last_available_mission_enrollment
    current_user.mission_enrollments.order("created_at DESC").limit(1).first
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :class => 'add_link')
  end

  def embedded_video(url)
    content_tag(:iframe,"",src: FormattedURL.url(url, :embed), frameborder: '0', allowfullscreen: 'allowfullscreen', width: 640,height: 360)
  end

end
