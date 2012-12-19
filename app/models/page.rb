class Page < ActiveRecord::Base
  attr_accessible :content, :locale, :name
end
