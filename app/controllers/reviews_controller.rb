class ReviewsController < ApplicationController
  before_action :set_store

  def index
    render json: @store.reviews
  end

private
  def set_store
    @store = current_user.stores.find(params[:store_id])
  end
end
