class ApplicationController < ActionController::API
  before_action :authenticate_request
  skip_before_action :authenticate_request, only: [:check_keys, :index, :show]
  before_action :check_keys, only: [:index, :show]
  before_action :set_price_constraints

  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    unless @current_user
      render json: { error: 'Not Authorized' }, status: 401
    end
    @current_user
  end

  def check_keys
    @current_user = CheckKeys.call(request.headers).result
    unless (@current_user || authenticate_request)
      render json: { error: 'Not Authorized' }, status: 401
      return ""
    end
  end

  def get_page
    @page_number = params.permit(:page_number)[:page_number]
    @page_number ||= 1
  end

  def set_price_constraints
    params[:min_price] ? @min_price = params[:min_price] : @min_price = 0
    params[:max_price] ? @max_price = params[:max_price] : @max_price = 99999999
  end

  def formatted_response(arr2, per = 48)
    arr = arr2.to_a.uniq
    {
      arr: Kaminari.paginate_array(arr).page(get_page).per(per).map {|e|
        {product: e, set_price: e.get_price(current_user)}
      },
      pages: Kaminari.paginate_array(arr).page(get_page).per(per).total_pages
    }
  end

  def order_by(products)
    params.permit(:sort_by)[:sort_by] ? @sort_by = params.permit(:sort_by)[:sort_by] : @sort_by = "az"
    if @sort_by === "price"
      return products.joins(:set_prices).where(set_prices: {user_id: current_user.id}).order("set_prices.price desc")
    else
      return products.order("name asc")
    end
  end

  def filter_prices(products)
    products.joins(:set_prices).where("set_prices.price >= ? AND set_prices.price <= ?", @min_price.to_f, @max_price.to_f)
  end
end
