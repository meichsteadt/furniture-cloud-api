class PopularProductsController < ApplicationController
  def index
    @products = current_user.products.left_joins(:views).group("products.id").order("count(ahoy_events.id) desc").limit(12)
    render json: formatted_response(@products)
  end
end
