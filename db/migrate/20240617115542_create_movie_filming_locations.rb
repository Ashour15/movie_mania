class CreateMovieFilmingLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_filming_locations, id: false do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :filming_location, null: false, foreign_key: true
    end

    add_index :movie_filming_locations, [:movie_id, :filming_location_id], unique: true, name: 'index_movie_locations_on_movie_and_location'
  end
end
