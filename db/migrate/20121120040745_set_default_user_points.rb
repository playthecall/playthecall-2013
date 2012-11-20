class SetDefaultUserPoints < ActiveRecord::Migration
  def change
    change_column :users, :points, :integer, default: 0
  end
end
