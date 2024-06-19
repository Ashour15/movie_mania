class Actor < ApplicationRecord
  #Relations -------------------------------
  has_many :movie_actors, dependent: :destroy
  has_many :movies, through: :movie_actors

  #Validations -----------------------------
  validates :name, presence: true, uniqueness: true
end
