module ApplicationHelper
  def st(*args, &block)
    t(*args, &block).html_safe
  end

  def aside_present?
    @user.present? and not @user.new_record?
  end
end
