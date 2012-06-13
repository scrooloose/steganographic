FactoryGirl.define do
  factory :response do
    attempts 0
    association :user
    association :challenge
    correct false
    show_vowels :false
  end
end
