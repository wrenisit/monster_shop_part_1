class Merchant::OrdersController < Merchant::BaseController
  def show
    merchant = current_user.merchant
    @order = merchant.orders.find(params[:id])
    @item_orders = merchant.item_orders_from(@order)
  end

  def update
    order = Order.find(params[:id])
    order.update(status: "packaged")
  end
end