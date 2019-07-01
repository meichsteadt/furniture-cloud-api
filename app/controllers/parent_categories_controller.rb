class ParentCategoriesController < ApplicationController
  def index
    render json:
    current_user.parent_categories.joins(categories: {products: [:products_users, :views]}).where("products_users.user_id = ?", current_user.id).group("parent_categories.id").order("count(ahoy_events) desc")
  end
end
