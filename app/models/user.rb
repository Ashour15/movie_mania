class User < ApplicationRecord
  #Relations -----------------------------
  has_many :reviews, dependent: :destroy

  #Validations -----------------------------
  validates :name, presence: true, uniqueness: true
end
  