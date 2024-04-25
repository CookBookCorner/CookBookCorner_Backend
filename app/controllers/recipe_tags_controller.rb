class RecipeTagsController < ApplicationController
  before_action :set_recipe_tag, only: [:destroy]
  before_action :authenticate_user!

  def create
    @recipe_tag = RecipeTag.new(recipe_tag_params)
    if @recipe_tag.save
      render json: @recipe_tag, status: :created
    else
      render json: @recipe_tag.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe_tag.destroy
    head :no_content
  end

  private
  def set_recipe_tag
    @recipe_tag = RecipeTag.find(params[:id])
  end

  def recipe_tag_params
    params.require(:recipe_tag).permit(:recipe_id, :tag_id)
  end
end
