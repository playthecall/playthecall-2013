class AddOracleToMissionEnrollments < ActiveRecord::Migration
  def change
    add_column :mission_enrollments, :oracle_id, :int
  end
end
