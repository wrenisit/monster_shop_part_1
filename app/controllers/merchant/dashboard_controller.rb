class Merchant::DashboardController < Merchant::BaseController
  def index
    @user = current_user
  end
  def item_index
    @user = current_user
  end
end
