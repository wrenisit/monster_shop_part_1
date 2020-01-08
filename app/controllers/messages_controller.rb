class MessagesController < ApplicationController

  def create
    merchant = Merchant.find(params[:id])
    Message.create(merchant: merchant, user: current_user, title: params[:title], body: params[:body], sender_id: current_user.id)
    flash[:success] = "Your message has been sent."
    redirect_to "/profile/messages"
  end

end
