class SetPricesController < ApplicationController
  before_action :set_product

  def index

  end

private

  def set_product
    @product = current_user.products.find(params[:product_id])
  end

  def set_price_params
    params.permit(:page_number, :max_price, :min_price, :sort_by, :product_id)
  end
end
