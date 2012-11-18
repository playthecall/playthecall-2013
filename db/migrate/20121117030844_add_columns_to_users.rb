class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string
    add_column :users, :nickname,  :string

    add_column :users, :element, :string
    add_column :users, :avatar,  :string

    add_column :users, :language,  :string

    add_column :users, :game_version_id, :integer
    add_column :users, :points,          :integer

    add_column :users, :provider,     :string
    add_column :users, :uid,          :string
    add_column :users, :access_token, :string

    add_index :users, :element
    add_index :users, :game_version_id
    add_index :users, [:provider, :uid], unique: true
  end
end
