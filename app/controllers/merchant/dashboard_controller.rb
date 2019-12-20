class Merchant::DashboardController < Merchant::BaseController
  def index
    @merchant = current_user
  end
end
