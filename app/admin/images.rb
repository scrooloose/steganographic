ActiveAdmin.register Image do
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Image" do
      f.input :name
      f.input :image, :hint => (f.object.image? && f.template.image_tag(f.object.image.url(:default)))
    end

    f.buttons
  end

  show do
    div :class => "panel" do
      h3 "Image"

      div do
        image_tag(image.image.url(:default))
      end
    end

    default_main_content
  end
end
