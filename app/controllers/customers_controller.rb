class CustomersController < ApplicationController
  skip_before_action :authenticate_request
  before_action :check_keys
  before_action :set_store
  def index

  end

  def show

  end

  def create
    @customer = Customer.new(customer_params)
    @customer.store_id = params[:store_id]
    if @customer.save!
      render json: {:status => :created}
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

private
  def customer_params
    params.require(:customer).permit(:email, :name, :store_id)
  end

  def set_store
    @store = Store.find(params[:store_id])
  end
end
