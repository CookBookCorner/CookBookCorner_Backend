require 'rails_helper'
RSpec.describe Ingredient, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      ingredient = Ingredient.new(name: 'Flour')
      expect(ingredient).to be_valid
    end

    it 'is not valid without a name' do
      ingredient = Ingredient.new(name: nil)
      expect(ingredient).not_to be_valid
      expect(ingredient.errors.messages[:name]).to include("can't be blank")
    end

    it 'is not valid with a duplicate name' do
      Ingredient.create(name: 'Sugar')
      duplicate = Ingredient.new(name: 'Sugar')
      expect(duplicate).not_to be_valid
      expect(duplicate.errors.messages[:name]).to include("has already been taken")
    end
  end
end
