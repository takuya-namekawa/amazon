class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = Address.all
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save!
    redirect_to  public_addresses_path
  end

  def edit
    @address = Address.find(params[:id])
  end


  private


  def address_params
    params.require(:address).permit(:name, :post_code, :shipping_address,  :customer_id )
  end


end
