class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user
      t.string :facebook_link
      t.string :twitter_link
      t.string :google_plus_link
      t.string :instagram_link

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
