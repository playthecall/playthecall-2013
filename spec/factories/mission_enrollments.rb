FactoryGirl.define do
  factory :mission_enrollment do
    title             'Random Mission Enrollment Title'
    description       'Random *Mission Enrollment* Content'

    validation_params YAML.dump(likes: 512)

    association :mission
    association :user
  end
end
