class Admin::ItemsController < Admin::BaseController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def toggle_active
    item = Item.find(params[:item_id])
    item.toggle!(:active?)
    redirect_to admin_dash_merchant_items_path(item.merchant)
    if item.active?
      flash[:success] = "#{item.name} is now avalible for sale."
    else
      flash[:success] = "#{item.name} is no longer for sale."
    end
  end
end