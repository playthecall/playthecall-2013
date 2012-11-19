class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.references :game_version

      t.string :slug
      t.string :title
      t.text   :description
      t.text   :html_description

      t.string  :element
      t.integer :position

      t.string :video_url
      t.string :image

      t.string :validation_class
      t.text   :validation_params

      t.timestamps
    end

    add_index :missions, :game_version_id
    add_index :missions, :element
    add_index :missions, :slug
  end
end
