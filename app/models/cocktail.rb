class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy # destroy doses but not ingredients
  has_many :ingredients, through: :doses

  # has_one_attached :photo

  validates :name, presence: true, uniqueness: true
end
