FactoryGirl.define do
  factory :mission do
    title       'Random Mission Title'
    description 'Random Mission *Content*'

    validation_class  'FacebookSocialMissionValidator'
    validation_params YAML.dump(likes: 1024, oracle: true)

    sequence(:slug){ |n| "mission-slug-#{n}" }
    association :chapter
  end
end