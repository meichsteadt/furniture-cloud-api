class SizesController < ApplicationController
  before_action :set_mattress
  def index
    render json: @mattress.sizes
  end
private

  def set_mattress
    @mattress = Mattress.find(params[:mattress_id])
  end
end
