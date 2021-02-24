class ItemsController < ApplicationController
before_action :authenticate_user!, except: [:index]
before_action :move_to_index, only: :new

  def index
  end

  def new
    @items = Item.new
  end

  def create
    @item = Item.create(item_params)
  end

private
  def item_params
    params.require(:item).permit(:name, :discription, :category_id, :condition_id, :postage_id, :prefecture_id, :shipping_date_id).merge(user_id: current_user.id)
  end

  def move_to_index
    @item = Item.find(params[:id])
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

end