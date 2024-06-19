class MovieActor < ApplicationRecord
  #Relations -------------------------------
  belongs_to :movie
  belongs_to :actor
end
  