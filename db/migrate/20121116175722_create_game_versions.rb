class CreateGameVersions < ActiveRecord::Migration
  def change
    create_table :game_versions do |t|
      t.string :name
      t.string :language
      t.timestamps
    end

    add_index :game_versions, :id,   unique: true
    add_index :game_versions, :name, unique: true
  end
end
