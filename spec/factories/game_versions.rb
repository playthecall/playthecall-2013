FactoryGirl.define do
  factory :game_version do
    sequence(:name){ |n| "Brasil (#{n})" }
    language 'pt-br'
  end
end
