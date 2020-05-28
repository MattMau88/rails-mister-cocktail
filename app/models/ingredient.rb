class Ingredient < ApplicationRecord
  has_many :doses # prevent (self-)destroy if it has dose children
  has_many :cocktails, through: :doses

  validates :name, presence: true, uniqueness: true
end
