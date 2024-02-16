class ProductsController < ApplicationController

  # Index
  def index
    @products = Product.includes(:category).all
  end

  # Show action
  def show
    debugger
    @product = Product.find(params[:id])
    logger.debug "Product details: #{@product.inspect}"
    debugger
  end
end
