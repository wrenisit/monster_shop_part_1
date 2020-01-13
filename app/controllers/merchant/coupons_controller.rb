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

  def create
    merchant = Merchant.find(current_user.merchant_id)
    merchant.coupons.create(coupon_params)
    redirect_to "/merchant/coupons"
  end

  private

  def coupon_params
    params.permit(:name, :amount)
  end

end
