FactoryGirl.define do
  factory :mission_enrollment do
    title             'Random Mission Enrollment Title'
    description       'Random *Mission Enrollment* Content'

    validation_params YAML.dump(likes: 512, oracle_validation: false)

    association :mission
    # TODO: Wait for model user
    # association :user
  end
end
