class ItemsController < ApplicationController
before_action :authenticate_user!, except: [:index]
before_action :move_to_loginpage, only: :new

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

private
  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :postage_id, :prefecture_id, :shipping_date_id, :price, :image).merge(user_id: current_user.id)
  end

  def move_to_loginpage
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

end