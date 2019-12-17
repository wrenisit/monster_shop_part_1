class SessionsController < ApplicationController

  def new
  end

  def create
    user_login = User.find_by(email: params[:email])
    if user_login != nil && user_login.authenticate(params[:password]) 
      session[:user_id] = user_login.id
      if user_login.user?  
        flash[:success] = "Welcome #{user_login.email}"
        redirect_to "/profile"
      elsif user_login.merchant_employee? || user_login.merchant_admin?
        flash[:success] = "Welcome Merchant #{user_login.email}"
        redirect_to "/merchants/dashboard"
      elsif user_login.admin_user? 
        flash[:success] = "Welcome Admin #{user_login.email}!"
        redirect_to "/admin/dashboard"
      end
    else
      flash[:error] = "Sorry Invalid Password or Email."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "You are now logged out."
    redirect_to "/"
  end
end
