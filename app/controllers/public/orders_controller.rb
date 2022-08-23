class Public::OrdersController < ApplicationController
  def confirm
    @cart_items = current_customer.cart_items.all

    @order = Order.new(order_params)

    @order.post_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
    if params[:order][:address] == "1"
    @order.address = current_customer.address

    elsif params[:order][:address] == "2"
    ship = Address.find(params[:order][:address_id])
    @order.post_code = ship.post_code
    @order.address = ship.shipping_address
    @order.name = ship.name
    end
    #@order = current_customer.order.all
    @total = 0
    @order.shipping_cost = 800

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
        order_item.order_quantity = cart.amount
        order_item.price = cart.item.price
        order_item.save
      end
      redirect_to public_thanks_path

    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def thanks
      current_customer.cart_items.destroy_all
  end

  def index
     @orders = current_customer.orders
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit( :shipping_cost, :total_payment,:payment_method,:name,:address,:post_code)
  end

  def address_params
  params.require(:order).permit(:customer_id, :shipping_cost, :total_payment,:payment_method,:name,:address,:post_code,:status,:payment_method)
  end
end
