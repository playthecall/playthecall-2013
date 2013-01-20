class Page < ActiveRecord::Base
  attr_accessible :content, :locale, :name, :html_description, :slug
end
