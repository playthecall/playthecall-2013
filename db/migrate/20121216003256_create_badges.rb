class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :image
      t.integer :mission_id

      t.timestamps
    end
  end
end
