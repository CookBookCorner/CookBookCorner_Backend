class Recipe < ApplicationRecord
  has_one_attached :recipe_picture
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_tags
  has_many :tags, through: :recipe_tags

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :preparation_time, :cooking_time, presence: true, numericality: { greater_than: 0 }
  validates :servings, numericality: { only_integer: true, greater_than: 0 }
  validates :instructions, presence: true
  validates :difficulty, presence: true
  enum difficulty: { easy: 'easy', medium: 'medium', hard: 'hard' }
end