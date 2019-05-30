class SearchesController < ApplicationController
  skip_before_action :authenticate_request
  before_action :check_keys

  def create
    params.permit(:sort_by)[:sort_by] ? @sort_by = params.permit(:sort_by)[:sort_by] : @sort_by = "az"
    render json: formatted_response(get_products)
  end

private
  def search_params
    params.permit(:query)
  end

  def get_products
    @products = order_by(
      filter_prices(
        Product.search(search_params[:query], current_user, @sort_by)[:products]
      )
    )
  end
end
