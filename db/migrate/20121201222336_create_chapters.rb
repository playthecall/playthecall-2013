class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.references :game_version
      t.string :name

      t.timestamps
    end
    add_index :chapters, :game_version_id
  end
end
