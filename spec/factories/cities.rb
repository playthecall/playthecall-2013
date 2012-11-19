FactoryGirl.define do
  factory :city do
    sequence(:code){ |n| "city#{n}" }
    sequence(:name){ |n| "City #{n}" }
    latitude    0
    longitude   0
    association :country
  end
end
