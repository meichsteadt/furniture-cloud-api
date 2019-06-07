class SetTypesProductsController < ApplicationController
  before_action :get_products, only: [:show]

  def show
    render json: formatted_response(@products)
  end

private

  def get_products
    @products = order_by(
      filter_prices(
        current_user.products.joins(:set_types).where(set_types: {name: unlink_name(allowed_params[:id])})
      )
    )
  end

  def unlink_name(name)
    name.gsub("-", " ").gsub("&", "/").titlecase
  end

  def category_id
    parent_category_id = ParentCategory.find_by("lower(name) = ?", allowed_params[:parent_category_id]).id
    Category.find_by("name = ? AND parent_category_id = ?", unlink_name(allowed_params[:category_id]), parent_category_id).id
  end

  def allowed_params
    params.permit(:id, :parent_category_id, :category_id)
  end

end
