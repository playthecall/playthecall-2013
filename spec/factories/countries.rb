FactoryGirl.define do
  factory :country do
    sequence(:code){ |n| "country#{n}" }
    sequence(:name){ |n| "Country #{n}" }
  end
end
