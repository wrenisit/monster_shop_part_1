class Merchant::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def fulfill
    order = Order.find(params[:id])
    order.update(status: "packaged")
  end
end