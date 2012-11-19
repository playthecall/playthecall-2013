class CreateCountries < ActiveRecord::Migration
  def change
    create_table(:countries) do |t|
      t.column :name, :string
      t.column :code, :string

      t.timestamps
    end
  end
end
