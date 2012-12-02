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
end
