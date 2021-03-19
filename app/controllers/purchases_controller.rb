class PurchasesController < ApplicationController
  def index
    @item_purchase = ItemPurchase.new
    @item = Item.find(params[:item_id])
  end
 
  def create
    @item_purchase = ItemPurchase.new(purchase_params)
    @item = Item.find(params[:item_id])
     if @item_purchase.valid?
       @item_purchase.save
       redirect_to root_path
     else
       render action: :index
     end
  end
 
  private
   # 全てのストロングパラメーターを1つに統合
  def purchase_params
   params.require(:item_purchase).permit(:user_id, :item_id, :postal_code, :prefecture_id, :municipalities, :address_line1, :address_line2, :phone_number, :purchase_id)
  end
end
