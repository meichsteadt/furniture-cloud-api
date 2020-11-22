class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :update, :destroy]
  before_action :set_visit
  # GET /carts
  def index
    if @visit
      if @visit.cart
        @carts = @visit.cart
      else
        @carts = Cart.create(visit_id: @visit.id)
      end
    else
      @carts = Cart.all
    end
    render json: @carts
  end

  # GET /carts/1
  def show
    render json: @cart
  end

  # POST /carts
  def create
    @cart = Cart.new(cart_params)

    if @cart.save
      render json: @cart, status: :created, location: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /carts/1
  def update
    if @cart.update(cart_params)
      render json: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # DELETE /carts/1
  def destroy
    if params[:product_id]
      @cart_item = CartItem.find_by(product_id: params[:product_id])
      @cart_item.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    def set_visit
      @visit = Ahoy::Visit.find_by(visit_token: params[:visit_id])
    end

    # Only allow a trusted parameter "white list" through.
    def cart_params
      params.require(:cart).permit(:belongs_to, :belongs_to)
    end
end
