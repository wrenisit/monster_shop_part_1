class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart, :current_user, :current_merchant_user?

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_merchant_user?
    current_user && (current_user.merchant_employee? || current_user.merchant_admin?)
  end

  def cart
    session[:cart] ||= Hash.new(0)
    @cart ||= Cart.new(session[:cart])
  end

end
