class AddHtmlDescriptionToPages < ActiveRecord::Migration
  def change
    add_column :pages, :html_description, :text
  end
end
