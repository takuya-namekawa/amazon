class Public::OrdersController < ApplicationController
  def confirm
      @cart_items = current_customer.cart_items.all
      @order = Order.new(order_params)
    #@order.address = params[:order][:address]
    if params[:order][:address] == "1"
      @order.address = current_customer.address
     
    else params[:order][:address] == "2"
    ship = Address.find(params[:order][:address])

    @order.address = ship.address
   
    end
    #@order = current_customer.order.all
    @total = 300


  end

  def new
     @order = Order.new
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart|
        order_item = OrderItem.new
        order_item.item_id = cart.item_id
        order_item.order_id = @order.id
        order_item.order_quantity = cart.quantity
        order_item.order_price = cart.item.price
        order_item.save
      end
      redirect_to public_comfirm_path
      cart_items.destroy_alls
    else
      @order = Order.new(order_params)
      render :new
    end
  end


  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :shipping_cost, :total_payment,:payment_method,:name,:address,:post_code,:status)
  end

  def address_params
  params.require(:order).permit(:customer_id, :shipping_cost, :total_payment,:payment_method,:name,:address,:post_code,:status)
  end
end
