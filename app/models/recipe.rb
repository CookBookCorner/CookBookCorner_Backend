class Recipe < ApplicationRecord
  has_one_attached :recipe_picture
  belongs_to :user

  has_many :recipe_tags
  has_many :tags, through: :recipe_tags

  validates :title, presence: true
  validates :preparation_time, :cooking_time, :servings, numericality:{greater_than: 0}
  
  enum difficulty: {easy: 'easy', medium: 'medium', hard: 'hard'}
end
