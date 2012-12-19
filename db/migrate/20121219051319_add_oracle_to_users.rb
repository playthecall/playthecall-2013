class AddOracleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oracle_id, :int
  end
end
