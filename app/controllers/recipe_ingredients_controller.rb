class RecipeIngredientsController < ApplicationController
  before_action :set_recipe_ingredient, only: [:update, :destroy]
  before_action :authenticate_user!

  def create
    @recipe_ingredient = RecipeIngredient.new(recipe_ingredient_params)
    if @recipe_ingredient.save
      render json: @recipe_ingredient, status: :created
    else
      render json: @recipe_ingredient.errors, status: :unprocessable_entity
    end
  end

  def update
    if @recipe_ingredient.update(recipe_ingredient_params)
      render json: @recipe_ingredient
    else
      render json: @recipe_ingredient.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe_ingredient.destroy
    head :no_content
  end

  private
  def set_recipe_ingredient
    @recipe_ingredient = RecipeIngredient.find(params[:id])
  end

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:recipe_id, :ingredient_id, :quantity)
  end
end
