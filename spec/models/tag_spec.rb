require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      tag = Tag.new(name: 'Dessert')
      expect(tag).to be_valid
    end

    it 'is not valid without a name' do
      tag = Tag.new(name: nil)
      expect(tag).not_to be_valid
      expect(tag.errors[:name]).to include("can't be blank")
    end

    it 'is not valid with a duplicate name' do
      Tag.create(name: 'Dessert')
      duplicate_tag = Tag.new(name: 'Dessert')
      expect(duplicate_tag).not_to be_valid
      expect(duplicate_tag.errors[:name]).to include("has already been taken")
    end
  end

  describe 'associations' do
    it 'has many recipe_tags' do
      association = described_class.reflect_on_association(:recipe_tags)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many recipes through recipes_tags' do
      association = described_class.reflect_on_association(:recipes)
      expect(association).not_to be_nil
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:recipe_tags)
    end
  end
end
