class MattressesController < ApplicationController
  before_action :filter_params
  before_action :set_mattress, only: [:show, :edit, :update, :destroy]
  def index
    # binding.pry
    render json: formatted_mattress_response(
      filter_mattresses(current_user.mattresses)
    )
  end

  def show
    render json: {mattress: @mattress, price: @mattress.get_price(current_user, "all")}
  end

private

  def filter_params
    permitted_params[:size] ? @size = permitted_params[:size] : @size = nil
    permitted_params[:min_price] ? @min_price = permitted_params[:min_price] : @min_price = 0
    permitted_params[:max_price] ? @max_price = permitted_params[:max_price] : @max_price = 3000
  end

  def set_mattress
    @mattress = current_user.mattresses.find(permitted_params[:id])
  end

  def filter_mattresses(mattresses)
    filter_price(@min_price, @max_price, mattresses.get_size(@size, current_user.id))
  end

  def filter_price(min, max, array)
    if array
      array.joins(:sizes).where("sizes.price <= ? AND sizes.price >= ?", max, min)
    else
      []
    end
  end

  def formatted_mattress_response(arr2, size = nil, per = 48)
    arr = arr2.to_a.uniq
    size_book = {}
    arr2.joins(:sizes).pluck("id", "sizes.name", "sizes.price").each do |e|
      if size_book[e[0]].nil? || e[2] > size_book[e[0]][:price]
        size_book[e[0]] = {name: e[1], price: e[2]}
      end
    end
    # binding.pry
    {
      arr: Kaminari.paginate_array(arr).page(get_page).per(per).map {|e|
        {mattress: e, price: e.get_price(current_user, size_book[e.id][:name])}
      },
      pages: Kaminari.paginate_array(arr).page(get_page).per(per).total_pages
    }
  end

  def permitted_params
    params.permit(:min_price, :max_price, :size, :id)
  end
end
