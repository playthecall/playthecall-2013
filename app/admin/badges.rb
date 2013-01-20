ActiveAdmin.register Badge do
  filter :mission 

  index do
    column :mission
    column :image
    default_actions
  end

  show do |m|
    attributes_table do
      row :mission
      row :image do
        image_tag(m.image.medium)
      end
      row :message
    end
  end

  form :html => { :multipart => true } do |f|
    f.inputs "Content" do
      f.input :mission
      f.input :image, as: :file, hint:
        if f.object.image? then f.template.image_tag(f.object.image.medium) end
      f.input :message, as: :html_editor
    end

    f.buttons
  end
end
