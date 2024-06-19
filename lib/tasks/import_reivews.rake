namespace :import do
  desc "Import reviews"
  task reviews: :environment do
    require 'csv'
    Rails.logger.info "CSV import task has started"

    batch_size = 1000
    file_path = 'data/reviews.csv'
    process_csv(file_path, batch_size)

    Rails.logger.info "CSV review import task completed successfully"
  end
end

def prepare_reviews_data(file_path)
  reviews_data = []

  CSV.foreach(file_path, headers: true) do |row|
    movie_name = row['Movie']
    user_name = row['User']
    stars = row['Stars'].to_i  
    review = row['Review']
    
    movie = Movie.find_by(title: movie_name)

    next unless movie
    
    user = User.find_by(name: user_name)

    if !user
      user = User.create!(name: user_name) 
    end
    
    reviews_data << {
      movie_id: movie.id,
      user_id: user.id,
      stars: stars,
      review: review,
      created_at: Time.now,
      updated_at: Time.now
    }
  rescue StandardError => e
    Rails.logger.error "Error during review data processing for user #{user_name}: #{e.message}"
  end
  reviews_data
end

def process_csv(file_path, batch_size)
  reviews_data = prepare_reviews_data(file_path)
  
  ActiveRecord::Base.transaction do
    reviews_data.each_slice(batch_size) do |batch|
        Review.insert_all(reviews_data)
    end
  end
end
  