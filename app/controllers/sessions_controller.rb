class SessionsController < ApplicationController

  def new
    if current_admin_user?
      flash[:error] = "You are already logged in."
      redirect_to "/admin"
    elsif current_merchant_user?
      flash[:error] = "You are already logged in."
      redirect_to "/merchant"
    elsif current_user
      flash[:error] = "You are already logged in."
      redirect_to "/profile"
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if login_successful?(user)
      session[:user_id] = user.id
      welcome(user)
    else
      flash[:error] = "Sorry Invalid Password or Email."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    session.delete(:cart)
    flash[:success] = "You are now logged out."
    redirect_to "/"
  end

  def login_successful?(user)
    !user.nil? && user.authenticate(params[:password])
  end

  def welcome(user)
    if current_admin_user?
      flash[:success] = "Welcome Admin #{user.email}!"
      redirect_to "/admin"
    elsif current_merchant_user?
      flash[:success] = "Welcome Merchant #{user.email}"
      redirect_to "/merchant"
    else
      flash[:success] = "Welcome #{user.email}"
      redirect_to "/profile"
    end
  end
end
