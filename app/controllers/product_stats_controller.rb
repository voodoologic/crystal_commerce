class ProductStatsController < ApplicationController
  def index
  end

  def show
    id = show_params[:product_id]
    @product = Product.find_by_id(id)
    @listings = Listing.where(product: @product)
  end

  def search
    id = search_params[:product_id]
    @product = Product.find_by_id(id)
    if !@product.present?
      flash[:warn] = "There is no product with the id of #{id}"
      redirect_to action: :index
    else
      redirect_to action: show, id: @product.id
    end
  end

  private

  def search_params
    params.permit(:product_id)
  end

  def show_params
    params.permit(:product_id)
  end
end
