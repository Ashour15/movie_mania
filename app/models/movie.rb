class Movie < ApplicationRecord
  #Relations -------------------------------
  belongs_to :director
  belongs_to :country

  has_many :reviews, dependent: :destroy

  has_many :movie_filming_locations
  has_many :filming_locations, through: :movie_filming_locations
  
  has_many :movie_actors, dependent: :destroy
  has_many :actors, through: :movie_actors


 #Validations -----------------------------
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :year, presence: true
  validates :director_id, presence: true
  validates :country_id, presence: true

 #Scopes -----------------------------
  scope :sorted_by_average_stars, -> {
    left_joins(:reviews)
    .group(:id)
    .order('AVG(reviews.stars) DESC NULLS LAST')
  }

  def average_stars
    reviews.average(:stars).to_f.round(1)
  end
end

  