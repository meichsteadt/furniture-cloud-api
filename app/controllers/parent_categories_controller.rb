class ParentCategoriesController < ApplicationController
  def index
    render json:
    current_user.parent_categories.joins(categories: {products: :products_users}).where("products_users.user_id = ?", current_user.id).distinct
  end
end
