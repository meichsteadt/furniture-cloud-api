class RelatedProductsController < ApplicationController
  before_action :set_product
  def index
    render json: @product.related_products.map {|e| Product.find(e.related_product_id)}
  end

private
  def set_product
    @product = current_user.products.find(params[:product_id])
  end
end
