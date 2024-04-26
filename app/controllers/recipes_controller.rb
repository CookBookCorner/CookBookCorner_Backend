class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  # GET /recipes
  def index
    if params[:search].present?
      @recipes = Recipe.where("LOWER(title) LIKE LOWER(?)", "%#{params[:search]}%")
    else
      @recipes = Recipe.all
    end
    if params[:tags].present?
      @recipes = @recipes.joins(:tags).where(tags: {name: params[:tags].split(",")})
    end
    render json: @recipes
  end
  # GET /recipes/1
  def show
    render json: @recipe
  end
  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      render json: @recipe, status: :created, location: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end
  #PATCH/PUT /recipes/1
  def update
    if @recipe.update(recipe_params)
      render json: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end
  # DELETE /recipes/1
  def destroy
    @recipe.destroy
    head :no_content
  end

  private
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
  def recipe_params
    params.require(:recipe).permit(:title, :preparation_time, :cooking_time, :servings, :difficulty, :instructions, :user_id)
  end
end
