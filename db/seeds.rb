# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

puts "Cleaning database..."
Ingredient.destroy_all

puts "Deleted old data and now creating ingredients..."

url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"

serialized_ingredients = open(url).read
parsed_ingredients = JSON.parse(serialized_ingredients)

parsed_ingredients["drinks"].each do |i|
  Ingredient.create(name: i["strIngredient1"])
end


puts "Finished!"
