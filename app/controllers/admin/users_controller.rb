class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @display_user = User.find(params[:id])
  end
end