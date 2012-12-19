FactoryGirl.define do
  factory :enrollment_image do
    association :mission_enrollment
    image "/assets/rails.png"
  end
end
