class CreateCities < ActiveRecord::Migration
  def change
    create_table(:cities) do |t|
      t.column :code, :string
      t.column :name, :string
      t.column :latitude, :float
      t.column :longitude, :float
      t.column :country_id, :int

      t.timestamps
    end
  end
end
