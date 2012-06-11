FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "foo#{n}@example.com"
    end

    password "foobar"
  end
end
