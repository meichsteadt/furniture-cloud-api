class PromotionsProductsController < ApplicationController
  before_action :get_products

  def index
    render json: formatted_response(@products)
  end

private
  def get_products
    @products =
    order_by(
      filter_prices(
        current_user.promotions.find_by_name(unlink_name(allowed_params[:promotion_id])).products
      )
    )
  end

  def order_by(products)
    params.permit(:sort_by)[:sort_by] ? @sort_by = params.permit(:sort_by)[:sort_by] : @sort_by = "az"
    if @sort_by === "price"
      products.joins(:set_prices).order("set_prices.price desc")
    else
      return products.order("name asc")
    end
  end

  def filter_prices(products)
    products.joins(:set_prices).where("set_prices.price >= ? AND set_prices.price <= ? AND set_prices.user_id = ?", @min_price.to_f, @max_price.to_f, current_user.id)
  end

  def unlink_name(name)
    name.gsub("-", " ").gsub("&", "/").titlecase
  end

  def allowed_params
    params.permit(:promotion_id, :page_number, :max_price, :min_price, :id)
  end
end
