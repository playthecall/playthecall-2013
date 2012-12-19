class CreateOracles < ActiveRecord::Migration
  def change
    create_table :oracles do |t|
      t.string :email

      t.timestamps
    end
  end
end
