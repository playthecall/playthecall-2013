class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    remove_column :users, :full_name
  end
end
