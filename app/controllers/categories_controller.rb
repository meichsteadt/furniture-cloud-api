class CategoriesController < ApplicationController
  before_action :set_category, only: [:destroy, :update]

  def index
    render json: current_user.categories.joins(products: {products: :views}).order("count(ahoy_events.id) desc").group("categories.id").distinct.pluck(:parent_category)
  end

  def show
    render json: current_user.categories.where(parent_category_id: ParentCategory.find_by("lower(name) = ?", unlink_name(params[:id])).id).joins(:products).distinct
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save!
      product_ids.each {|e| @category.products << Product.find(e)}
      render json: @category
    else
      render json: @category.errors, :status => :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      @category.products.delete_all
      product_ids.each {|e| @category.products << Product.find(e)}
      render json: {message: "category item updated successfully"}
    else
      render json: @category.errors, :status => :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    render json: {message: "category destroyed successfully"}
  end

  private

  def unlink_name(name)
    name.gsub("-", " ").gsub("&", "/")
  end

  def set_category
    @category = current_user.categories.find_by(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :parent_category)
  end

  def product_ids
    params.permit(:product_ids => [])
  end
end
