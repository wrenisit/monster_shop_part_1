class Admin::MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
  end

  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.active == true
      update_item_status(merchant, false)
      merchant.toggle!(:active)
      flash[:notice] = "Merchant has been deactivated"
      redirect_to "/admin/merchants"
    else
      update_item_status(merchant, true)
      merchant.toggle!(:active)
      flash[:notice] = "Merchant has been activated"
      redirect_to "/admin/merchants"
    end
  end

  private
    def update_item_status(merchant, status)
      merchant.items.each do |item|
        item.update(active?: status)
      end
    end
end
