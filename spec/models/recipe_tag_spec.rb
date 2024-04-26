require 'rails_helper'

RSpec.describe RecipeTag, type: :model do
  describe 'associations' do
    it 'belongs to recipe' do
      association = described_class.reflect_on_association(:recipe)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to tag' do
      association = described_class.reflect_on_association(:tag)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.create(email: 'user@example.com', password: 'password')
      recipe = Recipe.create(title: 'Test Recipe', preparation_time: 10, cooking_time: 20, servings: 4, difficulty: 'easy', instructions: 'Test instructions', user: user)
      tag = Tag.create(name: 'Dessert')
      recipe_tag = RecipeTag.new(recipe_id: recipe.id, tag_id: tag.id)
      expect(recipe_tag).to be_valid
    end

    it 'is not valid without a recipe' do
      tag = Tag.create(name: 'Dessert')
      recipe_tag = RecipeTag.new(tag_id: tag.id)
      expect(recipe_tag).not_to be_valid
      expect(recipe_tag.errors[:recipe]).to include('must exist')
    end

    it 'is not valid without a tag' do
      user = User.create(email: 'user@example.com', password: 'password')
      recipe = Recipe.create(title: 'Test Recipe', preparation_time: 10, cooking_time: 20, servings: 4, difficulty: 'easy', instructions: 'Test instructions', user: user)
      recipe_tag = RecipeTag.new(recipe_id: recipe.id)
      expect(recipe_tag).not_to be_valid
      expect(recipe_tag.errors[:tag]).to include('must exist')
    end
  end
end
