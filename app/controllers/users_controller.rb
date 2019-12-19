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
    if password?
      password_update
    elsif uniq_email?
      update_e_params(true)
    else !uniq_email?
      update_e_params
    end
  end

  def password_edit
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

  def e_params
    params.permit(:name, :address, :city, :state, :zip, :email)
  end

  def password_params
    params.permit(:password, :password_confirmation)
  end

  def update_e_params(bool = false)
    if bool == true
      @user = @user.update(e_params)
      flash[:success] = "Your profile has been updated."
      redirect_to '/profile'
    else
      flash[:error] = "This email is already used."
      render :edit
    end
  end

  def password_update
    @user = @user.update(password_params)
    flash[:success] = "Your password has been updated."
    redirect_to '/profile'
  end

  def password?
    params.include?(:password)
  end

  def uniq_email?
    @user.email == e_params[:email] || User.find_by(email: e_params[:email]) == nil
  end
end
