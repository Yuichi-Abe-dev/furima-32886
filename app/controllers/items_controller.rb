class ItemsController < ApplicationController
  before_action :move_to_loginpage, only: :new

  def index
    @item = Item.includes(:user).order("created_at ASC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :postage_id, :prefecture_id,
                                 :shipping_date_id, :price, :image).merge(user_id: current_user.id)
  end

  def move_to_loginpage
    redirect_to new_user_session_path unless user_signed_in?
  end
end
