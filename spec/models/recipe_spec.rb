require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(email: 'user@example.com', password: 'password') }
  let(:valid_attributes) {
    { 
      title: 'New Recipe',
      preparation_time: 10,
      cooking_time: 20,
      servings: 4,
      difficulty: 'easy',
      instructions: 'Some instructions',
      user: user
    }
  }

  describe 'validations' do
    it 'is valid with valid attributes' do
      recipe = Recipe.new(valid_attributes)
      expect(recipe).to be_valid
    end

    it 'is not valid without a title' do
      invalid_attributes = valid_attributes.merge(title: nil)
      recipe = Recipe.new(invalid_attributes)
      expect(recipe).not_to be_valid
      expect(recipe.errors[:title]).to include("can't be blank")
    end

    it 'requires a positive preparation time' do
      invalid_attributes = valid_attributes.merge(preparation_time: 0)
      recipe = Recipe.new(invalid_attributes)
      expect(recipe).not_to be_valid
      expect(recipe.errors[:preparation_time]).to include("must be greater than 0")
    end

    it 'requires a positive cooking time' do
      invalid_attributes = valid_attributes.merge(cooking_time: 0)
      recipe = Recipe.new(invalid_attributes)
      expect(recipe).not_to be_valid
      expect(recipe.errors[:cooking_time]).to include("must be greater than 0")
    end

    it 'requires a positive servings' do
      invalid_attributes = valid_attributes.merge(servings: 0)
      recipe = Recipe.new(invalid_attributes)
      expect(recipe).not_to be_valid
      expect(recipe.errors[:servings]).to include("must be greater than 0")
    end

    it 'ensures difficulty is present and valid' do
      invalid_attributes = valid_attributes.merge(difficulty: nil)
      recipe = Recipe.new(invalid_attributes)
      expect(recipe).not_to be_valid
      expect(recipe.errors[:difficulty]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'has many recipe_ingredients' do
      association = described_class.reflect_on_association(:recipe_ingredients)
      expect(association).not_to be_nil  # This will confirm if the association is being recognized
      expect(association.macro).to eq(:has_many)
    end
  
    it 'has many ingredients through recipe_ingredients' do
      association = described_class.reflect_on_association(:ingredients)
      expect(association).not_to be_nil  # This will confirm if the association is being recognized
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:recipe_ingredients)
    end
  end
end
