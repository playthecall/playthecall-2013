class AlterElementInUsers < ActiveRecord::Migration
  def change
    change_column :users, :element, :string, default: ''
  end
end
