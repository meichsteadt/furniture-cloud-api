class SetTypesController < ApplicationController
  before_action :set_category

  def index
    render json: @category.set_types
  end

private
  def set_category
    @parent_category = ParentCategory.find_by("lower(name) = ?", params[:parent_category_id])
    @category = @parent_category.categories.find_by(name: unlink_name(params[:category_id]))
  end

  def unlink_name(name)
    name.gsub("-", " ").gsub("&", "/").titlecase
  end
end
