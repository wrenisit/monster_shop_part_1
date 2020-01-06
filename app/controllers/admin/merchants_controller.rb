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
      merchant.toggle!(:active)
      flash[:notice] = "Merchant has been deactivated"
      redirect_to "/admin/merchants"
    else
      merchant.toggle!(:active)
      flash[:notice] = "Merchant has been activated"
      redirect_to "/admin/merchants"
    end
  end
end
