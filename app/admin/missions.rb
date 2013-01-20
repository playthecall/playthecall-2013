# encoding: utf-8
ActiveAdmin.register Mission do

  controller do
    defaults finder: :find_by_slug
  end

  menu :label => 'Missions'

  filter :chapter_id
  filter :title
  filter :element

  scope :admin_order, :default => true

  index do
    column :title
    column :chapter
    column :element
    column :position
    default_actions
  end

  show do |m|
    attributes_table do
      row :id
      row :slug
      row :title
      row :description
      row :html_description
      row :element
      row :position
      row :video_url
      if m.image.present?
        row :image do
          image_tag(m.image.medium)
        end
      end
      row :validation_class
      row :validation_params
      row :created_at
      row :updated_at
      row :chapter_id
      if m.badge.present?
        row :badge do
          image_tag(m.badge.image.medium)
        end
      end
    end
  end

  form :html => { :multipart => true } do |f|
    f.inputs "Content" do
      f.input :chapter, as: :select,
              collection: option_groups_from_collection_for_select(
                GameVersion.all, :chapters, :name, :id, :name, f.object.chapter_id
              )

      f.input :slug
      f.input :title
      f.input :description, as: :html_editor

      f.input :video_url
      f.input :image, as: :file

      f.input :element, as: :select, collection: User::ELEMENTS
      f.input :position

      f.input :validation_class, as: :select, collection: MissionValidator::VALIDATORS
      f.input :validation_params

      f.inputs "Badge image", for: [:badge, Badge.new] do |b|
        b.input :image, as: :file, :hint => ( f.object.badge.nil? ?
                                             f.template.content_tag(:span, "no badge yet") :
                                             f.template.image_tag(f.object.badge.image.medium) )
      end
    end
    f.buttons
  end
end
