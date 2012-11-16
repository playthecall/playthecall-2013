require 'nokogiri'

class DescriptionSpecHelper
  def initialize(resource, css_selector)
    @resource, @css_selector = resource, css_selector
  end

  def tags
    @tags ||= Nokogiri.XML(@resource.html_description).search(@css_selector)
  end

  def empty?
    tags.count == 0
  end

  def match_contents(contents)
    contents.each_with_index do |content, index|
      begin
        return false if content != tags[index].text
      rescue
        return false
      end
    end
    return true
  end
end

RSpec::Matchers.define :have_description_tag do |css_selector, *contents|
  match do |actual|
    description_helper = DescriptionSpecHelper.new actual, css_selector
    !description_helper.empty? && description_helper.match_contents(contents)
  end
end