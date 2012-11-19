class AlterElementInMissions < ActiveRecord::Migration
  def change
    change_column :missions, :element, :string, default: ''
  end
end
