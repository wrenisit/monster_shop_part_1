class Admin::UsersController < Admin::BaseController
  def index
    @users = User.unscoped.all
  end

  def show
    @display_user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.toggle!(:active)
    redirect_to admin_dash_users_path
    if !user.active
      flash[:success] = "#{user.name} has been disabled."
    else
      flash[:success] = "#{user.name} has been enabled."
    end
  end
end
