class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :destroy, :update]
  def index
    render json: formatted_response(current_user.products)
  end

  def show
    render json: {product: @product, set_price: @product.get_price(current_user)}
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save!
      render json: @product
    else
      render json: @product.errors, :status => :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: {message: "product item updated successfully"}
    else
      render json: @product.errors, :status => :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    render json: {message: "product destroyed successfully"}
  end

private

  def set_product
    @product = current_user.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :brand_id, :image)
  end
end
