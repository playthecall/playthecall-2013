FactoryGirl.define do
  factory :user do
    sequence(:nickname){ |n| "nickname-#{n}" }
    sequence(:email){ |n| "person#{n}@example.com" }
    password              'password'
    password_confirmation 'password'
    confirmed_at          DateTime.now
    gender                'male'
    element               ''
    association :city
    association :game_version
    association :profile
  end
end
