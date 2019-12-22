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
      redirect_to profile_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if params[:password]
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

  def update_e_params(bool = false)
    if bool == true
      @user = @user.update(user_params)
      flash[:success] = "Your profile has been updated."
      redirect_to '/profile'
    else
      flash[:error] = "This email is already used."
      render :edit
    end
  end

  def password_update
    if params[:password] == params[:password_confirmation]
      @user = @user.update(user_params)
      flash[:success] = "Your password has been updated."
      redirect_to '/profile'
    else
      flash[:error] = "Passwords entered do not match."
      redirect_to '/profile/password'
    end
  end

  def uniq_email?
    @user.email == params[:email] || User.find_by(email: params[:email]) == nil
  end
end
