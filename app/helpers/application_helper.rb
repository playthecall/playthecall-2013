module ApplicationHelper
  def st(*args, &block)
    t(*args, &block).html_safe
  end
end
