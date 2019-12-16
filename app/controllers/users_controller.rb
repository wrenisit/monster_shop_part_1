class UsersController<ApplicationController
  def new
  end

  def create
    User.create(user_params)
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password)
  end
end
