class ProductStatsController < ApplicationController
  def index
  end

  def show
    id = permitted_params[:product_id]
    @product = Product.find_by_id(id)
    if !@product.present?
      redirect_to_index(id)
    else
      @listings = Listing.where(product: @product)
      @prices = @listings.map(&:price).map(&:to_f)
    end
  end

  def search
    id = permitted_params[:product_id]
    @product = Product.find_by_id(id)
    if !@product.present?
      redirect_to_index(id)
    else
      redirect_to action: :show, product_id: @product.id
    end
  end

  private

  def permitted_params
    params.permit(:product_id)
  end

  def redirect_to_index(id)
    flash[:warn] = "There is no product with the id of #{id}"
    redirect_to action: :index
  end

end
