class CategoriesProductsController < ApplicationController
  before_action :get_products, only: [:show]

  def show
    render json: formatted_response(@products)
  end

private

  def get_products
    @products = order_by(
      filter_prices(
        current_user.products.joins(:categories).where(categories: {name: unlink_name(allowed_params[:id]), parent_category: allowed_params[:parent_category]})
      )
    )
  end

  def unlink_name(name)
    name.gsub("-", " ").gsub("&", "/").titlecase
  end

  def allowed_params
    params.permit(:id, :parent_category)
  end

end
