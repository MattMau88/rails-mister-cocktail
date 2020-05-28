class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy # destroy doses but not ingredients
  has_many :ingredients, through: :doses

  validates :name, presence: true, uniqueness: true
end
