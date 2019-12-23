class OrdersController <ApplicationController

  def new
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    user = current_user
    order = user.orders.create(order_params)
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      session.delete(:cart)
      flash[:notice] = "Order Placed"
      redirect_to order_path(order)
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end

  def index
    @user = current_user
  end

  def cancel
    @order = Order.find(params[:id])
    @order.cancel
    flash[:notice] = "Order cancelled"
    redirect_to profile_path
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
