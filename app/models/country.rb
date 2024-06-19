class Country < ApplicationRecord
  #Relations -------------------------------
  has_many :movies

  #Validations -----------------------------
  validates :name, presence: true, uniqueness: true
end
