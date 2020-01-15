class CouponsController < ApplicationController
  before_action :exclude_admin

  def new
  end

  def create
    coupon = Coupon.find_by(name: params[:name])
    redirect_to "/cart/#{coupon.id}"
  end

end
