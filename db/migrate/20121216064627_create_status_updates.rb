class CreateStatusUpdates < ActiveRecord::Migration
  def change
    create_table :status_updates do |t|
      t.integer :mission_enrollment_id
      t.text :status
      t.text :html_status

      t.timestamps
    end
  end
end
