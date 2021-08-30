class Admin::OrderItemsController < ApplicationController
  def update
    order_item = OrderItem.find(params[:id])
    order_item.update(order_item_params)
    
    order = Order.find_by(id: order_item.order_id)
    if order_item.making_status == "in_making"
      order.update(status: "in_making")
    end  
    
    order_items = order.order_items
    if order_items.pluck(:making_status).all?{ |n| n == "complete" }
      order.update(status: "preparing")
    end
    
    redirect_to admin_order_path(order_item.order_id), notice: '更新しました'
  end
  
  private
    def order_item_params
      params.require(:order_item).permit(:making_status)
    end
end
