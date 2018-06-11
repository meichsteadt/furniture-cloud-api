class FinancingsController < ApplicationController
  def index
    render json: current_user.financings
  end
end
