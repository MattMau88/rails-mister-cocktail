class CocktailsController < ApplicationController

  # A user can see the list of cocktails
  # GET "cocktails"
  def index
    @cocktails = Cocktail.all
  end

  # A user can create a new cocktail
  # GET "cocktails/new"
  def new
    @cocktail = Cocktail.new
  end

  # POST "cocktails"
  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to @cocktail
    else
      render 'new'
    end
  end

  # A user can see the details of a given cocktail, with the dose needed for each ingredient
  # GET "cocktails/42"
  def show
    @cocktail = Cocktail.find(params[:id])
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end

end
