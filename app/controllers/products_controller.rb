class ProductsController < ApplicationController

  # Index
  def index
    @products = Product.includes(:category).all
  end

  # Show action
  def show
    @product = Product.find(params[:id])
  end
end
