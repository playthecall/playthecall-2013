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
end
