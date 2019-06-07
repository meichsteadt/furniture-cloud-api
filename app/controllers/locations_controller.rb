class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :destroy, :update, :edit]
  before_action :set_store

  def index
    render json: @store.locations
  end

  def show
    render json: @location
  end

  def create
    @location = current_user.locations.new(location_params)
    if @location.save!
      render json: @location
    else
      render json: @location.errors, :status => :unprocessable_entity
    end
  end

  def update
    if @location.update(location_params)
      render json: {message: "location was updated successfully"}
    else
      render json: @location.errors, :status => :unprocessable_entity
    end
  end

  def destroy
    @location.destroy
    render json: {message: "location was successfully destroyed"}
  end

private

  def set_location
    @location = current_user.locations.find(params[:id])
  end

  def set_store
    @store = current_user.stores.find(params[:store_id])
  end

  def location_params
    params.require(:location).permit(:id, :name, :address, :city, :state, :zip, :phone, :email, :hours)
  end

end
