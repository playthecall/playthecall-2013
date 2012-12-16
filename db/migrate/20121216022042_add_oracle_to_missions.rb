class AddOracleToMissions < ActiveRecord::Migration
  def change
    add_column :missions, :oracle, :boolean
  end
end
