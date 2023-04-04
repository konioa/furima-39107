class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]

  def index
    @order_payment = OrderPayment.new
  end

  def create
    @order_payment = OrderPayment.new(order_params)
    if @order_payment.valid?
      @order_payment.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    params.require(:order_payment).permit(:postcode, :prefecture_id, :city, :block, :building, :phone).merge(user_id: current_user.id, item_id: @item.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
