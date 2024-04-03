class Recipe < ApplicationRecord
  has_one_attached :recipe_picture
  belongs_to :user
end
