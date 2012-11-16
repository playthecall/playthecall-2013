class CreateMissionEnrollments < ActiveRecord::Migration
  def change
    create_table :mission_enrollments do |t|
      t.references :mission
      t.references :user

      t.string  :title
      t.text    :description
      t.text    :html_description

      t.boolean :accomplished
      t.text    :validation_params

      t.timestamps
    end

    add_index :mission_enrollments, :mission_id
    add_index :mission_enrollments, :user_id
  end
end
