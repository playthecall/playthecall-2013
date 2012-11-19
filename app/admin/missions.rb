# encoding: utf-8
ActiveAdmin.register Mission do
  menu :label => 'Missions'

  filter :game_version_id
  filter :title
  filter :element

  scope :admin_order, :default => true

  index do
    column :title
    column :game_version
    column :element
    column :position
    default_actions
  end

  form :html => { :multipart => true } do |f|
    f.inputs "Content" do
      f.input :game_version_id, as: :select, collection: GameVersion.all

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
