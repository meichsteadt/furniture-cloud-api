class RelatedProductsController < ApplicationController
  before_action :set_product
  def index
    render json: current_user.products.where(id: @product.related_products.pluck(:related_product_id))
  end

private
  def set_product
    @product = current_user.products.find(params[:product_id])
  end
end
