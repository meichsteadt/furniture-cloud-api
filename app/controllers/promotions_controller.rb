class PromotionsController < ApplicationController
  before_action :set_promotion, only: [:show, :destroy, :update]
  def index
    render json: current_user.promotions
  end

  def show
    render json: {promotion: @promotion, products: @promotion.products}
  end

  def create
    @promotion = current_user.promotions.new(promotion_params)
    if @promotion.save!
      product_ids.each {|e| @promotion.products << Product.find(e)}
      render json: @promotion
    else
      render json: @promotion.errors, :status => :unprocessable_entity
    end
  end

  def update
    if @promotion.update(promotion_params)
      @promotion.products.delete_all
      product_ids.each {|e| @promotion.products << Product.find(e)}
      render json: {message: "promotion item updated successfully"}
    else
      render json: @promotion.errors, :status => :unprocessable_entity
    end
  end

  def destroy
    @promotion.destroy
    render json: {message: "promotion destroyed successfully"}
  end

  private

  def set_promotion
    @promotion = current_user.promotions.find(params[:id])
  end

  def promotion_params
    params.require(:promotion).permit(:name, :url, :image, :discount, :promotion_id, :page_number, :max_price, :min_price, :id)
  end

  def product_ids
    params.permit(:product_ids => [])
  end
end
