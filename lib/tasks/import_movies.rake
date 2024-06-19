# lib/tasks/import_movies.rake

namespace :import do
  desc "Import movies"
  task movies: :environment do
    require 'csv'
    Rails.logger.info "CSV import task has started"
    file_path = 'data/movies.csv'
    process_movies_csv(file_path)
    Rails.logger.info "CSV import task completed successfully"
  end
end

def prepare_data(file_path)
  directors_to_insert = []
  movies_to_insert = []
  countries_to_insert = []
  actors_to_insert = []
  movies_actors_to_insert = []

  CSV.foreach(file_path, headers: true) do |row|
    movie_title = row['Movie']
    description = row['Description']
    director_name = row['Director']
    country_name = row['Country']
    actor_name = row['Actor']
    year = row['Year']

    movies_to_insert << {
      title: movie_title,
      description: description,
      year: year,
      created_at: Time.now,
      updated_at: Time.now,
      director_name: director_name, 
      country_name: country_name,
      actor_name: actor_name
    }

    directors_to_insert << { name: director_name, created_at: Time.now, updated_at: Time.now }
    countries_to_insert << { name: country_name, created_at: Time.now, updated_at: Time.now }
    actors_to_insert << { name: actor_name, created_at: Time.now, updated_at: Time.now }
    movies_actors_to_insert << { movie_title: movie_title,actor_name: actor_name }
  end
  [movies_to_insert, directors_to_insert, countries_to_insert, actors_to_insert, movies_actors_to_insert]
end

def process_movies_csv(file_path)
  movies_to_insert, directors_to_insert, countries_to_insert, actors_to_insert, movies_actors_to_insert = prepare_data(file_path)
  batch_size = 1000 
  begin
    ActiveRecord::Base.transaction do
      Director.insert_all(directors_to_insert.uniq { |director| director[:name] }, unique_by: :name)
      directors_to_insert.each_slice(batch_size) do |batch|
        Director.insert_all(batch, unique_by: :name)
      end
    end

    ActiveRecord::Base.transaction do
      Country.insert_all(countries_to_insert.uniq { |country| country[:name] }, unique_by: :name)
      countries_to_insert.each_slice(batch_size) do |batch|
        Country.insert_all(batch, unique_by: :name)
      end
    end

    ActiveRecord::Base.transaction do
      Actor.insert_all(actors_to_insert.uniq { |actor| actor[:name] }, unique_by: :name)
      actors_to_insert.each_slice(batch_size) do |batch|
        Actor.insert_all(batch, unique_by: :name)
      end
    end

    directors = Director.pluck(:name, :id).to_h
    countries = Country.pluck(:name, :id).to_h
    actors = Actor.pluck(:name, :id).to_h

    movies_to_insert.each do |movie_attrs|
      movie_attrs[:director_id] = directors[movie_attrs[:director_name]]
      movie_attrs[:country_id] = countries[movie_attrs[:country_name]]
      movie_attrs.delete(:director_name)
      movie_attrs.delete(:country_name)
      movie_attrs.delete(:actor_name)
    end

    ActiveRecord::Base.transaction do
      movies_to_insert.each_slice(batch_size) do |batch|
        Movie.insert_all(batch)
      end
    end

      movies = Movie.pluck(:title, :id).to_h
      movies_actors_to_insert.map! do |ma|
        {
          movie_id: movies[ma[:movie_title]],
          actor_id: actors[ma[:actor_name]],
          created_at: Time.now,
          updated_at: Time.now
        }
      end

    ActiveRecord::Base.transaction do
      movies_actors_to_insert.uniq.each_slice(batch_size) do |batch|
        MovieActor.insert_all(batch)
      end
    end
  rescue StandardError => e
    Rails.logger.error "Error during movie data processing from CSV: #{e.message}"
  end
end
