class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:show]
  before_action :set_cart_item_from_product, only: [:destroy, :update]
  before_action :set_cart
  skip_before_action :authenticate_request
  before_action :check_keys

  # GET /cart_items
  def index
    if @cart
      if !params[:cart_item_only]
        @cart_items = Product.joins(:cart_items).where("cart_items.cart_id = ?", @cart.id)
      else
        @cart_items = @cart.cart_items
      end
    else
      @cart_items = CartItem.all
    end
    render json: @cart_items
  end

  # GET /cart_items/1
  def show
    render json: @cart_item
  end

  # POST /cart_items
  def create
    @cart_item = @cart.cart_items.new(cart_item_params)

    if @cart_item.save
      render json: @cart_item, status: :created, location: @cart_item
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cart_items/1
  def update
    if @cart_item.update(cart_item_params)
      render json: @cart_item
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cart_items/1
  def destroy
    @cart_item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    def set_cart_item_from_product
      @cart_item = CartItem.find_by(cart_id: params[:cart_id], product_id: params[:product_id])
    end

    def set_cart
      @cart = Cart.find(params[:cart_id])
    end

    # Only allow a trusted parameter "white list" through.
    def cart_item_params
      params.require(:cart_item).permit(:cart_id, :product_id, :quantity)
    end
end
