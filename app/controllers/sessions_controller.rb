class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    session[:user_id] = user.id
    flash[:success] = "Welcome #{user.email}"
    redirect_to "/profile"
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "You are now logged out."
    redirect_to "/"
  end
end
