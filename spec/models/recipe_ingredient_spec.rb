require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  describe 'associations' do
    it 'belong to recipe' do
      association = described_class.reflect_on_association(:recipe)
      expect(association.macro).to eq(:belongs_to)
    end
    it 'belongs to ingredient' do
      association = described_class.reflect_on_association(:ingredient)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
