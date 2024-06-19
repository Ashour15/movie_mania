class FilmingLocation < ApplicationRecord
  #Relations -------------------------------
  has_many :movie_filming_locations, dependent: :destroy
  has_many :movies, through: :movie_filming_locations

  #Validations -----------------------------
  validates :name, presence: true, uniqueness: true
end
