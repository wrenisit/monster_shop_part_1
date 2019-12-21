class Merchant::OrdersController < Merchant::BaseController
  def show
    @order = Order.find(params[:id])
  end

  def fulfill
    order = Order.find(params[:id])
    order.update(status: "packaged")
  end
end