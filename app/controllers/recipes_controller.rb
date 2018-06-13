class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
    if @recipe.ingredients.last.try(:name)
     @recipe.ingredients.build
    end
  end

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    2.times do
      @recipe.ingredients.build()
    end
  end

  def create
    @recipe = Recipe.new
    @recipe.ingredients.build(recipe_params[:ingredients_attributes]["0"])
    @recipe.ingredients.build(recipe_params[:ingredients_attributes]["1"])
    @recipe.title = recipe_params[:title]
    if @recipe.save
      redirect_to @recipe
    else
      render :new
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, ingredients_attributes: [:id, :name, :quantity])
  end
end
