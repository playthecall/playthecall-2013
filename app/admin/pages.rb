# encoding: utf-8
ActiveAdmin.register Page do
  menu :label => 'Pages'

  filter :name
  filter :slug
  filter :locale

  #scope :admin_order

  index do
    column :name
    column :slug
    column :locale
    column :created_at
    default_actions
  end

  form :html => { :multipart => true } do |f|
    f.inputs "Content" do
      f.input :name
      f.input :slug
      f.input :locale
      f.input :content
    end
    f.buttons
  end
end

