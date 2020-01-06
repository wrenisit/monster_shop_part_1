class Merchant::ItemsController < Merchant::BaseController
  def index
      @merchant = current_user.merchant
  end

  def toggle_active 
    item = Item.find(params[:item_id])
    item.toggle!(:active?)
    redirect_to "/merchant/items"
    flash[:success] = "Item is no longer for sale."
  end   

end