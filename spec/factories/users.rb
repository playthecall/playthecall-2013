FactoryGirl.define do
  factory :user do
    sequence(:nickname){ |n| "nickname-#{n}" }
    sequence(:email){ |n| "person#{n}@example.com" }
    password              'password'
    password_confirmation 'password'
    sex                   'male'
    element               ''
    association :city
    association :game_version
  end
end
