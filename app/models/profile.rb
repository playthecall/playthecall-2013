class Profile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :facebook_link, :google_plus_link, :instagram_link, :twitter_link,
                  :bio
end
