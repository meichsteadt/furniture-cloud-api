class ParentCategoriesController < ApplicationController
  def index
    render json: current_user.parent_categories
  end
end
