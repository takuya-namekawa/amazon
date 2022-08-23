class Admin::OrderItemsController < ApplicationController

  def update
   @order_item = OrderItem.find(params[:id])
   @order = @order_item.order
   @order_items = @order.order_items
   @order_item.update(order_items_params)
    if params[:order_item][:crafting_status] == "production"
      @order.update(status: "In_production")
    end

    if @order_items.count == @order_items.where(crafting_status: "production_completed").count
      @order.update(status: "Preparing_to_ship")
    end
    redirect_to admin_order_path(@order)
  end
#   ①注文ステータスが 入金確認 → 全ての製作ステータスを 製作待ち
# ②製作ステータスが一つでも 製作中 → 注文ステータスを 製作中
# where(カラム名: "検索したい値") count
# if ③製作ステータスが全て 製作完了
#   注文ステータスを 発送準備中
# end
# ③製作ステータスが全て 製作完了 → 注文ステータスを 発送準備中


    private

  def order_items_params
    params.require(:order_item).permit( :crafting_status)
  end

end
