class DosesController < ApplicationController
  # A user can add a new dose (ingredient/description pair) to an existing cocktail
  before_action :add_ingredient_and_cocktail_pair, only: [:new, :create]

  # GET "cocktails/42/doses/new"
  def new
    @dose = Dose.new
  end

  # POST "cocktails/42/doses"
  def create
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render 'new'
    end
  end

  # A user can delete a dose that belongs to an existing cocktail.
  # DELETE "doses/25"
  def destroy
    @dose = Dose.find(params[:id])
    @cocktail = @dose.cocktail
    @dose.destroy
    redirect_to cocktail_path(@cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end

  def add_ingredient_and_cocktail_pair
    @cocktail = Cocktail.find(params[:cocktail_id])
    @ingredients = Ingredient.all.order(name: :asc)
  end
end
