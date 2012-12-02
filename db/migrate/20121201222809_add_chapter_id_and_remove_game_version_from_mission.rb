class AddChapterIdAndRemoveGameVersionFromMission < ActiveRecord::Migration
  def change
    add_column    :missions, :chapter_id, :integer
    remove_column :missions, :game_version_id

    add_index :missions, :chapter_id
  end
end
