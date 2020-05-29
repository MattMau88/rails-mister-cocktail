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

puts "Deleted old data and now creating list of ingredients..."

url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"

serialized_ingredients = open(url).read
parsed_ingredients = JSON.parse(serialized_ingredients)

parsed_ingredients["drinks"].each do |i|
  Ingredient.create(name: i["strIngredient1"])
end


puts "Finished!"


if Rails.env.development?
  Dose.destroy_all
  Ingredient.destroy_all
  Cocktail.destroy_all
end

puts "deleted old data"


url = "https://raw.githubusercontent.com/maltyeva/iba-cocktails/master/recipes.json"

opened_url = open(url).read
parsed_url = JSON.parse(opened_url)


parsed_url.each do |cocktail|
  c = Cocktail.create!(name: cocktail["name"])
  cocktail["ingredients"].each do |ingredient|
    # Ingredient
    if ingredient["ingredient"]
      i = Ingredient.find_or_create_by(name: ingredient["label"].present? ? ingredient["label"] : ingredient["ingredient"])
      # Dose
      d = Dose.create!(description: ingredient["amount"].to_s + " " + ingredient["unit"], cocktail: c, ingredient: i)
      puts "Added #{d.description} of #{i.name} to #{c.name}"
    end
  end
end
