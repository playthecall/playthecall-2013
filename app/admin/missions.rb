# encoding: utf-8
ActiveAdmin.register Mission do

  before_filter { Mission.class_eval { def to_param; id.to_s; end } }

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

  form :html => { :multipart => true } do |f|
    f.inputs "Content" do
      f.input :chapter, as: :select,
              collection: option_groups_from_collection_for_select(
                GameVersion.all, :chapters, :name, :id, :name, f.object.chapter_id
              )

      f.input :slug
      f.input :title
      f.input :description

      f.input :video_url
      f.input :image, as: :file

      f.input :element, as: :select, collection: User::ELEMENTS
      f.input :position

      f.input :validation_class, as: :select, collection: MissionValidator::VALIDATORS
      f.input :validation_params
    end
    f.buttons
  end
end
