class CategoriesController < ApplicationController
  before_action :set_category, only: [:destroy, :update]

  def index
    render json: current_user.categories.pluck(:parent_category).distinct
  end

  def show
    render json: current_user.categories.where(parent_category: params[:id])
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
