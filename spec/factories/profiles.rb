FactoryGirl.define do
  factory :profile do
    bio              'My awesome bio'
    facebook_link    'facebook.com/some_user'
    twitter_link     'twitter.com/@some_user'
    google_plus_link 'plus.google.com/some_user'
    instagram_link   'instagram.com/some_user'
  end
end
