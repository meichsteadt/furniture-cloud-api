class ProductItemsController < ApplicationController
  before_action :set_product
  before_action :set_product_item, only: [:show, :destroy, :update]
  def index
    render json: @product.product_items
    .includes(:prices)
    .where(prices: {user_id: current_user.id})
    .order('prices.price desc')
    .map {|m|
      {product_item: m, price: m.prices.pluck(:price).first}
    }
  end

  def show
    render json: {product_item: @product_item, price: @product_item.get_price(current_user)}
  end

  def create
    @product_item = @product.product_items.new(product_item_params)
    if @product_item.save!
      @product_item.prices.create(user_id: current_user.id, price: @product_item.price)
      render json: @product_item
    else
      render json: @product_item.errors, :status => :unprocessable_entity
    end
  end

  def update
    if @product_item.update(product_item_params.except(:price))
      @product_item.prices.find_by(user_id: current_user.id).update(price: product_item_params[:price])
      render json: {message: "product item updated successfully"}
    else
      render json: @product_item.errors, :status => :unprocessable_entity
    end
  end

  def destroy
    @product_item.destroy
    render json: {message: "product item destroyed successfully"}
  end

private

  def set_product_item
    @product_item = @product.product_items.find(params[:id])
  end

  def set_product
    @product = current_user.products.find(params[:product_id])
  end

  def product_item_params
    params.require(:product_item).permit(:name, :dimensions, :price, :product_id)
  end
end
