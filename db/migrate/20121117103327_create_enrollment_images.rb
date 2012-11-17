class CreateEnrollmentImages < ActiveRecord::Migration
  def change
    create_table :enrollment_images do |t|
      t.string     :image
      t.references :mission_enrollment

      t.timestamps
    end
    add_index :enrollment_images, :mission_enrollment_id
  end
end
