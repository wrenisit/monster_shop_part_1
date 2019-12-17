class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user != nil && user.authenticate(params[:password]) && user.authenticate(params[:password_confirmation])
      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.email}"
      redirect_to "/profile"
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
