class SearchController < ApplicationController
  def search
    if params[:search].blank?
      flash[:alert] = "Empty field!"
      redirect_to root_path
    else
      @parameter = params[:search].downcase
      @results = Item.all.where("lower(items.name) LIKE ?","%#{@parameter}%" )
      redirect_to "/results/index"
    end
  end

  def index
  end
end
