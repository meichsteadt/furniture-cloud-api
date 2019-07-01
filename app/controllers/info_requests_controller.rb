class InfoRequestsController < ApplicationController
  skip_before_action :authenticate_request
  before_action :check_keys
  before_action :set_store

  def index

  end

  def show

  end

  def create
    @info_request = InfoRequest.new(info_request_params)
    @info_request.store_id = params[:store_id]
    if @customer
      @info_request.customer_id = @customer.id
    end

    if @info_request.save!
      render json: {:status => :created}
    else
      render json: @info_request.errors, status: :unprocessable_entity
    end
  end

private
  def info_request_params
    params.require(:info_request).permit(:email, :name, :note, :product_id)
  end

  def find_customer
    @customer = Customer.find_by_email(info_request_params[:email])
  end

  def set_store
    @store = Store.find(params[:store_id])
  end
end
