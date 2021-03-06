class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :country

      t.timestamps
    end

    add_index :cities, :name
    add_index :cities, :country
  end
end
