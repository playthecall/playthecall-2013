class AddPositionToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :position, :int
    add_index :chapters, [:position, :game_version_id], unique: true
  end
end
