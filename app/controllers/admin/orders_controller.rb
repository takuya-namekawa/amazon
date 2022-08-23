class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @total = 0
    @order.shipping_cost = 800
  end

  private

  def order_params
    params.require(:order).permit(:name, :address, :payment_method)
  end

end
