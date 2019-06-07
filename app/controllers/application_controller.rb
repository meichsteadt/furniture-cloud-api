class ApplicationController < ActionController::API
  before_action :authenticate_request
  skip_before_action :authenticate_request, only: [:check_keys, :index, :show]
  before_action :check_keys, only: [:index, :show]
  before_action :set_price_constraints

  attr_reader :current_user

  private

  def authenticate_request
    @current_user ||= AuthorizeApiRequest.call(request.headers, true).result
    unless @current_user
      render json: { error: 'Not Authorized' }, status: 401
    end
    @current_user
  end

  def check_keys
    @current_user ||= AuthorizeApiRequest.call(request.headers, false).result
    unless @current_user
      render json: { error: 'Not Authorized' }, status: 401
    end
  end

  def get_page
    @page_number = params.permit(:page_number)[:page_number].to_i
    @page_number ||= 1
  end

  def set_price_constraints
    params.permit(:min_price)[:min_price] ? @min_price = params.permit(:min_price)[:min_price] : @min_price = 0
    params.permit(:max_price)[:max_price] ? @max_price = params.permit(:max_price)[:max_price] : @max_price = 99999999
  end

  def formatted_response(arr2, per = 48)
    arr = arr2.to_a.uniq
    prices = SetPrice.where(user_id: current_user.id, product_id: arr.map {|m| m.id})
    promotion_prices = current_user.promotions.joins(:products).pluck('products.id', 'promotions.discount').to_h
    prices.each {|e| e.price = e.price * promotion_prices[e.product_id] if promotion_prices[e.product_id]}
    on_promo = promotion_prices.keys
    h = {
      arr: Kaminari.paginate_array(arr).page(get_page).per(per).map {|e|
        {product: e, set_price: prices.find {|s| s.product_id == e.id}.price, on_promo: on_promo.include?(e.id)}
      },
      pages: Kaminari.paginate_array(arr).page(get_page).per(per).total_pages
    }
    h
  end

  def order_by(products)
    params.permit(:sort_by)[:sort_by] ? @sort_by = params.permit(:sort_by)[:sort_by] : @sort_by = "az"
    if @sort_by === "price"
      products.joins(:set_prices).left_joins(:promotions).order("coalesce(promotions.discount, 1) * set_prices.price desc")
    else
      return products.order("name asc")
    end
  end

  def filter_prices(products)
    products.joins(:set_prices).left_joins(:promotions).where("set_prices.price >= ? AND set_prices.price <= ? AND set_prices.user_id = ?", @min_price.to_f, @max_price.to_f, current_user.id)
  end
end
