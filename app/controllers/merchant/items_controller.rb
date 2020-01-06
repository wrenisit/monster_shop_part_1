class Merchant::ItemsController < Merchant::BaseController
  def index
    @merchant = current_user.merchant
    @items = @merchant.items
  end
end