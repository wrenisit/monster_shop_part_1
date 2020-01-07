class Admin::UsersController < Admin::BaseController
  def index
    @users = User.unscoped.all
  end

  def show
    @display_user = User.find(params[:id])
  end

  def edit
    @display_user = User.find(params[:user_id])
  end

  def update
    @display_user = User.find(params[:user_id])
    if params[:password]
      password_update
    elsif @display_user.update(user_params)
      flash[:success] = "Your profile has been updated."
      redirect_to "/admin/users/#{@display_user.id}"
    else
      flash[:error] = @display_user.errors.full_messages.to_sentence
      redirect_to "/admin/users/#{@display_user.id}"
    end
  end
  
  def toggle_active
    user = User.find(params[:id])
    user.toggle!(:active)
    redirect_to admin_dash_users_path
    if !user.active
      flash[:success] = "#{user.name} has been disabled."
    else
      flash[:success] = "#{user.name} has been enabled."
    end
  end

  def edit_password
    @display_user = User.find(params[:user_id])
  end

private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

  def password_update
    if params[:password] == params[:password_confirmation]
      @display_user.update(user_params)
      flash[:success] = "Password has been updated."
      redirect_to "/admin/users/#{@display_user.id}"
    else
      flash[:error] = "Passwords entered do not match."
      redirect_to "/admin/users/#{@display_user.id}/edit_password"
    end
  end
end
