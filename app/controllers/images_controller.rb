class ImagesController < ApplicationController
  before_action :set_store
  def index
    render json: @store.images.pluck(:url)
  end
private
  def set_store
    @store = current_user.stores.find(params[:store_id])
  end
end
