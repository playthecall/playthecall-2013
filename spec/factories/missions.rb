FactoryGirl.define do
  factory :mission do
    title             'Random Mission Title'
    description       'Random Mission *Content*'

    validation_class  'FacebookSocialMissionValidator'
    validation_params YAML.dump(likes: 1024, oracle_validation: true)

    association :game_version
  end
end