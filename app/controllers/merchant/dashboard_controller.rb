class Merchant::DashboardController < Merchant::BaseController
  def index
    @merchant = current_user.merchant
    @messages = @merchant.messages_received
  end
end
