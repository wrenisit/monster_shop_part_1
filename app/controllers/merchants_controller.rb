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

  def messages_index
    merchant = Merchant.find(params[:merchant_id])
    @messages = merchant.messages_received
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name,:address,:city,:state,:zip)
  end

end
