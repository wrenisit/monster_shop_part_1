class Merchant::OrdersController < Merchant::BaseController
  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(status: "packaged")
  end
end