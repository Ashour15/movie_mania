class CreateFilmingLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :filming_locations do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :filming_locations, :name, unique: true
  end
end
