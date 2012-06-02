ActiveAdmin.register Image do
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Image" do
      f.input :name
      f.input :image, :hint => (f.object.image? && f.template.image_tag(f.object.image.url(:default)))
    end

    f.buttons
  end
end
