# encoding: utf-8
ActiveAdmin.register Chapter do
  menu :label => 'Chapters'

  filter :name
  filter :game_version

  scope :admin_order

  index do
    column :name
    column :game_version
    column :created_at
    default_actions
  end
end
