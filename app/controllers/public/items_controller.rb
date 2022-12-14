class Public::ItemsController < ApplicationController
  def index
     @items = Item.all
  end

  def new
     @item = Item.new

  end

  def create
    @item = Item.new(item_params)
    @item.save!
    redirect_to admin_items_path
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_item_path(@item)
  end


  private

  def item_params
    params.require(:item).permit(:name, :explanation, :price, :is_ordered, :image, :genre_id)
  end
end
