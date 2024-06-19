class Review < ApplicationRecord
  #Relations -------------------------------
  belongs_to :user
  belongs_to :movie


  #Validations -----------------------------
  validates :stars, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :review, presence: true
  validates_uniqueness_of :movie_id, scope: :user_id
end
