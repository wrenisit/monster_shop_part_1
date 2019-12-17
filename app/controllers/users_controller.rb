class UsersController<ApplicationController
  def new
    @user = User.new(user_params)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Congratulations! You are now registered and logged in."
      session[:user_id] = @user.id
      redirect_to "/profile"
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    @user = @user.update(user_edit_params)
    flash[:success] = "Your profile has been updated."
    redirect_to '/profile'
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

<<<<<<< HEAD
  def user_edit_params
    params.permit(:name, :address, :city, :state, :zip, :email)
=======
  def new_params
    params.permit(:name, :address, :city, :state, :zip)
>>>>>>> 372f6318a1aebe3f84dc33e3a152539f91181591
  end
end
