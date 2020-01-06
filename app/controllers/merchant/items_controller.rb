class Merchant::ItemsController < Merchant::BaseController
  def index
      @merchant = current_user.merchant
  end

  def toggle_active 
    item = Item.find(params[:item_id])
    item.toggle!(:active?)
    redirect_to "/merchant/items"
    if !item.active? 
      flash[:success] = "#{item.name} is no longer for sale."
    else 
      flash[:success] = "#{item.name} is now avalible for sale."
    end
  end   

end