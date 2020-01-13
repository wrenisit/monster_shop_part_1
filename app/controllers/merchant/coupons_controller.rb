class Merchant::CouponsController < Merchant::BaseController
  def index
    merchant = Merchant.find(current_user.merchant_id)
    @coupons = merchant.coupons.all
  end

  def show
    @coupon = Coupon.find(params[:id])
  end

  def new
  end
end
