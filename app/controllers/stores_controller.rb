class StoresController < ApplicationController
  before_action :set_store, only: [:show, :destroy, :update, :edit]
  def index
    render json: current_user.stores
  end

  def show
    render json: @store
  end

  def create
    @store = current_user.stores.new(store_params)
    if @store.save!
      render json: @store
    else
      render json: @store.errors, :status => :unprocessable_entity
    end
  end

  def update
    if @store.update(store_params)
      render json: {message: "store was updated successfully"}
    else
      render json: @store.errors, :status => :unprocessable_entity
    end
  end

  def destroy
    @store.destroy
    render json: {message: "store was successfully destroyed"}
  end

private

  def set_store
    @store = current_user.stores.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:id, :name, :address, :city, :state, :zip, :phone, :email, :hours)
  end

end
