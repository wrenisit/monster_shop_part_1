class MerchantsController <ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.create(merchant_params)
    if @merchant.save
      redirect_to merchants_path
    else
      flash[:error] = @merchant.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if @merchant.update(merchant_params)
      redirect_to merchant_path(@merchant)
    else
      flash[:error] = @merchant.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    Merchant.destroy(params[:id])
    redirect_to merchants_path
  end

  def active
    merchant = Merchant.find(params[:id])
    if merchant.active == true
      merchant.toggle(:active)
      flash[:notice] = "Merchant has been deactivated"
    else
      merchant.toggle(:active)
      flash[:notice] = "Merchant has been activated"
    end
  end

  private

  def merchant_params
    params.permit(:name,:address,:city,:state,:zip)
  end

end
