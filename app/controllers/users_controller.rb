class UsersController<ApplicationController
  before_action :require_user, only: [:show]

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
    if @user.email == e_params[:email] || User.find_by(email: e_params[:email]) == nil
      @user = @user.update(e_params)
      flash[:success] = "Your profile has been updated."
      redirect_to '/profile'
    else
      flash[:error] = "This email is already used."
      render :edit
    end
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

  def e_params
    params.permit(:name, :address, :city, :state, :zip, :email)
  end
end
