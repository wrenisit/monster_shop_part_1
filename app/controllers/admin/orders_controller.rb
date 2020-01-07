class Admin::OrdersController < Admin::BaseController
  def update
    order = Order.find(params[:id])
    order.update(status: "shipped")
    redirect_to "/admin"
  end

  def show
    user = User.find(params[:user_id])
    @order = user.orders.find(params[:id])
  end

  def cancel
    user = User.find(params[:user_id])
    @order = user.orders.find(params[:id])
    @order.cancel
    flash[:notice] = "Order cancelled"
    redirect_to "/admin/users/#{user.id}/orders/#{@order.id}"
  end
end
