class PromotionsProductsController < ApplicationController
  before_action :get_products

  def index
    render json: formatted_response(@products)
  end

private
  def get_products
    @products = order_by(
      filter_prices(
      current_user.promotions.find_by_name(unlink_name(allowed_params[:promotion_id])).products
      )
    )
  end

  def unlink_name(name)
    name.gsub("-", " ").gsub("&", "/").titlecase
  end

  def allowed_params
    params.permit(:promotion_id)
  end
end
