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

  def messages_index
    user = current_user
    @messages = user.messages_received
  end

  def messages_show
    @message = Message.find(params[:id])
  end

  def reply
    @merchant_id = params[:id]
  end

  def messages_destroy
    message = Message.find(params[:id])
    message.destroy
    redirect_to("/profile/messages")
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
    elsif @user.update(user_params)
      flash[:success] = "Your profile has been updated."
      redirect_to profile_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      redirect_back(fallback_location: profile_edit_path)
    end
  end

  def edit_password
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

  def password_update
    if params[:password] == params[:password_confirmation]
      @user.update(user_params)
      flash[:success] = "Your password has been updated."
      redirect_to profile_path
    else
      flash[:error] = "Passwords entered do not match."
      redirect_to profile_edit_password_path
    end
  end
end
