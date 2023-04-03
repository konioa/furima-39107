class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @order_payment = OrderPayment.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_payment = OrderPayment.new(order_params)
  end

  private
  def order_params
    params.require(:order_payment).permit(:postcode, :prefecture_id, :city, :block, :building, :phone).merge(user_id: current_user.id, item_id: @item_id)
  end
end
