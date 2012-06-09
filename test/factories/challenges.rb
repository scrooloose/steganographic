FactoryGirl.define do
  factory :challenge do
    answer "when pigs fly"
    association :user
    association :image_1, :factory => :image
    association :image_2, :factory => :image
    email "foo@example.com"
  end
end
