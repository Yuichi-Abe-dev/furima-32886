class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:index, :create]

  def index
    @item_purchase = ItemPurchase.new
  end

  def create
    @item_purchase = ItemPurchase.new(purchase_params)
    if @item_purchase.valid?
      pay_item
      @item_purchase.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  # 全てのストロングパラメーターを1つに統合
  def purchase_params
    params.require(:item_purchase).permit(:postal_code, :prefecture_id, :municipalities,
                                          :address_line1, :address_line2, :phone_number).merge(
                                            user_id: current_user.id, item_id: @item.id, token: params[:token]
                                          )
  end

  def set_purchase
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 環境変数により自身のPAY.JPテスト秘密鍵を取得
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: purchase_params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
