FactoryGirl.define do
  factory :image do
    name "pig"

    after_build do |b|
      b.image = File.new("#{Rails.root}/test/fixtures/files/pig.png")
    end

  end
end
