class SetPricesController < ApplicationController
  before_action :set_product

  def index

  end

private

  def set_product
    @product = current_user.products.find(params[:product_id])
  end
end
