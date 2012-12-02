FactoryGirl.define do
  factory :chapter do
    name 'Chapter Name'

    association :game_version
  end
end
