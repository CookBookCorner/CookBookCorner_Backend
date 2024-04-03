# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user1 = User.create!(
  email: "user1@example.com",
  password: "password",
  password_confirmation: "password"
)

user2 = User.create!(
  email: "user2@example.com",
  password: "password",
  password_confirmation: "password"
)

recipe1 = Recipe.create!(
  user: user1,
  title: "Chocolate Cake",
  preparation_time: 60,
  cooking_time: 30,
  servings: 8,
  difficulty: "medium",
  instructions: ["Preheat oven to 350 degrees.", "Mix ingredients.", "Bake for 30 minutes."],
  notes: "This cake is very rich and moist."
)

recipe2 = Recipe.create!(
  user: user2,
  title: "Spaghetti Carbonara",
  preparation_time: 20,
  cooking_time: 20,
  servings: 4,
  difficulty: "easy",
  instructions: ["Cook pasta.", "Prepare sauce.", "Mix pasta and sauce."],
  notes: "Use fresh eggs and pancetta."
)

