class ParentCategoriesController < ApplicationController
  def index
    @parent_categories = current_user.parent_categories.joins(categories: {products: [:products_users, :views]}).where("products_users.user_id = ?", current_user.id).group("parent_categories.id").order("count(ahoy_events) desc")
    if @parent_categories.length < current_user.parent_categories.joins(categories: {products: [:products_users]}).where("products_users.user_id = ?", current_user.id).length
      @parent_categories = current_user.parent_categories.joins(categories: {products: [:products_users]}).where("products_users.user_id = ?", current_user.id).group("parent_categories.id").order("parent_categories.name asc")
    end
    render json: @parent_categories
  end
end
