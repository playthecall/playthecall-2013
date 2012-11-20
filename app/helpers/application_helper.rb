module ApplicationHelper
  def st(*args, &block)
    t(*args, &block).html_safe
  end

  def parent_layout(layout)
    @view_flow.set(:layout,output_buffer)
    self.output_buffer = render file: "layouts/#{layout}"
  end 
end
