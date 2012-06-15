FactoryGirl.define do
  factory :image do
    name "pig"
    image_file_name "fake.png"
    image_file_size 10
    image_content_type "image/png"
    image_updated_at Time.now

    #after_build do |b|
    #  b.image = File.new("#{Rails.root}/test/fixtures/files/pig.png")
    #end

  end
end
