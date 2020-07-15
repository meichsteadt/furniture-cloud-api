class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :destroy, :update]
  before_action :set_cart, only: [:index]
  def index
    if @cart
      @products = formatted_response(Product.joins(:cart_items).where("cart_items.cart_id = ?", @cart.id))
    else
      @products = formatted_response(current_user.products)
    end

    render json: @products
  end

  def show
    promo = @product.promo(current_user)
    render json: {product: @product, set_price: @product.get_price(current_user), promo_price: promo[:price], promo_discount: promo[:discount], on_promo: !promo[:price].nil?}
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

  def set_cart
    @cart = Cart.find(params[:cart_id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :brand_id, :image, :page_number, :max_price, :min_price, :sort_by)
  end
end
