class Page < ActiveRecord::Base
  before_save :compile_content
  attr_accessible :content, :locale, :name, :html_description, :slug

  protected

  def compile_content
    if content_changed?
      self.html_description = RDiscount.new(content).to_html
    end
  end
end
